// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import '../models/model_pakar.dart';

// class DiagnosisScreen extends StatefulWidget {
//   const DiagnosisScreen({Key? key}) : super(key: key);

//   @override
//   _DiagnosisScreenState createState() => _DiagnosisScreenState();
// }

// class _DiagnosisScreenState extends State<DiagnosisScreen> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final List<Question> _questionList = [];
//   final Map<String, double> _penyakitMap = {};
//   final String _selectedAnswer = '';
//   final int _questionIndex = 0;
//   final Map<String, Aturan> _aturanMap = {};
//   final Map<String, Aturan> _gejalaMap = {};

//   @override
//   void initState() {
//     super.initState();
//     _loadQuestions();
//   }

//   void _loadQuestions() async {
//     // Mengambil semua gejala dari firestore
//     final gejalaRef = _firestore.collection('gejala');
//     final gejalaQuerySnapshot = await gejalaRef.get();
//     final List<Question> list = gejalaQuerySnapshot.docs.map((doc) {
//       final List<Answer> answerList = [
//         Answer(answerText: 'Tidak', nilaiCf: 0),
//         Answer(answerText: 'Tidak Tahu', nilaiCf: 0.2),
//         Answer(answerText: 'Sedikit Yakin', nilaiCf: 0.4),
//         Answer(answerText: 'Cukup Yakin', nilaiCf: 0.6),
//         Answer(answerText: 'Yakin', nilaiCf: 0.8),
//       ];

//       // Check if the field exists in the document before accessing it
//       final namaGejala =
//           doc.data().containsKey('namaGejala') ? doc['namaGejala'] : '';

//       return Question("Apakah Anda mengalami $namaGejala?", answerList);
//     }).toList();

//     setState(() {
//       _questionList.addAll(list);
//     });
//   }

//   List<String> _getAturanList(String gejala) {
//     return _aturanMap.keys.where((aturan) => aturan.contains(gejala)).toList();
//   }

//   Future<List<String>> _answerQuestion(double nilaiCf) async {
//     // Menghitung CF untuk setiap penyakit
//     final penyakitRef = _firestore.collection('penyakit');
//     final penyakitQuerySnapshot = await penyakitRef.get();
//     for (final penyakitDoc in penyakitQuerySnapshot.docs) {
//       final penyakitId = penyakitDoc.id;
//       final List<Aturan> aturanList = _getAturanList(penyakitId).cast<Aturan>();
//       double totalCf = 1;
//       aturanList.forEach((aturan) {
//         if (aturan.gejalaId == _selectedAnswer) {
//           totalCf *= aturan.bobot;
//         } else {
//           totalCf *= (1 - aturan.bobot);
//         }
//       });

//       _penyakitMap[penyakitId] = totalCf;
//     }

//     // Membuat list penyakit dengan nilai CF terbesar
//     final List<MapEntry<String, double>> penyakitEntries =
//         _penyakitMap.entries.toList();
//     penyakitEntries.sort((a, b) => b.value.compareTo(a.value));
//     final double maxCf = penyakitEntries[0].value;
//     final List<String> maxPenyakitList = penyakitEntries
//         .where((entry) => entry.value == maxCf)
//         .map((entry) => entry.key)
//         .toList();

//     Future<void> _populatePenyakitMap() async {
//       final aturanRef = _firestore.collection('aturan');
//       final aturanQuerySnapshot = await aturanRef.get();

//       // Initialize the map with empty GejalaCf objects
//       for (final penyakit in _penyakitList) {
//         _penyakitMap[penyakit] = {};
//         for (final gejala in _gejalaMap.keys) {
//           _penyakitMap[penyakit]![gejala] = GejalaCf(0, 0);
//         }
//       }

//       for (final aturanDoc in aturanQuerySnapshot.docs) {
//         final aturanData = aturanDoc.data();
//         final aturan = Aturan(
//           aturanData['penyakit_id'],
//           aturanData['gejala_id'],
//           aturanData['bobot'],
//         );
//         if (!_aturanMap.containsKey(aturan.gejalaId)) {
//           _aturanMap[aturan.gejalaId] = [];
//         }
//         _aturanMap[aturan.gejalaId]!.add(aturan);

//         // Update the GejalaCf object for the corresponding penyakit and gejala
//         final penyakitId = aturan.penyakitId;
//         final gejalaId = aturan.gejalaId;
//         final bobot = aturan.bobot;
//         final gejalaCf = _penyakitMap[penyakitId]![gejalaId]!;
//         if (bobot > 0) {
//           gejalaCf.positive += 1;
//         } else {
//           gejalaCf.negative += 1;
//         }
//         _penyakitMap[penyakitId]![gejalaId] = gejalaCf;
//       }
//     }

//     // Memperbaiki keakuratan hasil diagnosa dengan mengecek apakah ada penyakit yang memiliki bobot 0 di gejala yang dipilih, jika ada maka penyakit tersebut tidak mungkin terjadi dan harus dihapus dari daftar penyakit yang mungkin terkena.
//     final List<String> penyakitList = [];
//     for (final penyakit in maxPenyakitList) {
//       bool isValid = true;
//       for (final gejala in _gejalaMap.keys) {
//         if (_gejalaMap[gejala] == 1 &&
//                 !_penyakitMap[penyakit]![gejala]!.isPositive ||
//             _gejalaMap[gejala] == 0 &&
//                 _penyakitMap[penyakit]![gejala]!.isPositive) {
//           isValid = false;
//           break;
//         }
//       }
//       if (isValid) {
//         penyakitList.add(penyakit);
//       }
//     }
//     return penyakitList;
//   }

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }
