import 'package:cloud_firestore/cloud_firestore.dart';

//CLASS PENYAKIT
class Penyakit {
  late String _id;
  String get id => _id;
  set id(String value) {
    _id = value;
  }

  final String namaPenyakit;
  final String deskripsi;
  final String solusi;

  Penyakit({
    required this.namaPenyakit,
    required this.deskripsi,
    required this.solusi,
  });

  Map<String, dynamic> toJson() {
    return {
      'namaPenyakit': namaPenyakit,
      'deskripsi': deskripsi,
      'solusi': solusi,
    };
  }

  factory Penyakit.fromFirestore(
      QueryDocumentSnapshot<Map<String, dynamic>> json) {
    return Penyakit(
        namaPenyakit: json['namaPenyakit'],
        deskripsi: json['deskripsi'],
        solusi: json['solusi']);
  }
}

//CLASS GEJALA
class Gejala {
  late String _id;
  String get id => _id;
  set id(String value) {
    _id = value;
  }

  final String namaGejala;
  // final String nilaiCf;

  Gejala({required this.namaGejala});

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'namaGejala': namaGejala,
    };
  }

  factory Gejala.fromFirestore(
      QueryDocumentSnapshot<Map<String, dynamic>> json) {
    return Gejala(
      // id: json['id'],
      namaGejala: json['namaGejala'],
    );
  }
}

//CLASS ATURAN
class Aturan {
  late String _id;
  String get id => _id;
  set id(String value) {
    _id = value;
  }

  final String gejalaId;
  final String penyakitId;
  final double bobot;

  Aturan({
    required this.gejalaId,
    required this.penyakitId,
    required this.bobot,
  });

  Map<String, dynamic> toJson() {
    return {
      'gejalaId': gejalaId,
      'penyakitId': penyakitId,
      'bobot': bobot,
    };
  }

  factory Aturan.fromFirestore(
      QueryDocumentSnapshot<Map<String, dynamic>> json) {
    return Aturan(
      gejalaId: json['gejalaId'],
      penyakitId: json['penyakitId'],
      bobot: json['bobot'],
    );
  }
}

class Question {
  final String questionText;
  final List<Answer> answers;

  Question(this.questionText, this.answers);
}

class Answer {
  final String answerText;
  final double nilaiCf;

  Answer({
    required this.answerText,
    required this.nilaiCf,
  });
}

// class DiagnosisService {
//   FirebaseFirestore firestore = FirebaseFirestore.instance;

//   Future<Map<String, double>> getPenyakitCf(
//       List<Gejala> selectedGejalaIds) async {
//     Map<String, double> penyakitCf = {};

//     // Dapatkan semua aturan yang terkait dengan gejala yang dipilih
//     QuerySnapshot<Map<String, dynamic>> aturanSnapshot = await firestore
//         .collection('aturan')
//         .where('gejalaId', whereIn: selectedGejalaIds)
//         .get()
//         .catchError((error) {
//       print(error);
//     });

//     // Untuk setiap aturan, hitung certainty factor untuk penyakit yang terkait
//     aturanSnapshot.docs.forEach((aturanDoc) async {
//       Map<String, dynamic> aturan = aturanDoc.data();
//       QuerySnapshot<Map<String, dynamic>> aturanPenyakitSnapshot =
//           await firestore
//               .collection('aturanPenyakit')
//               .where('penyakitId', isEqualTo: aturan['penyakitId'])
//               .get()
//               .catchError((error) {
//         print(error);
//       });

//       int n = aturanPenyakitSnapshot.size;
//       double cf = aturan['nilaiCf'];
//       aturanPenyakitSnapshot.docs.forEach((aturanPenyakitDoc) {
//         Map<String, dynamic> aturanPenyakit = aturanPenyakitDoc.data();
//         if (!selectedGejalaIds.contains(aturanPenyakit['gejalaId'])) {
//           cf *= (1 - aturanPenyakit['nilaiCf']);
//         }
//       });

//       String penyakitId = aturan['penyakitId'];
//       if (penyakitCf.containsKey(penyakitId)) {
//         double oldCf = penyakitCf[penyakitId]!;
//         penyakitCf[penyakitId] = oldCf + (cf * (1 - oldCf));
//       } else {
//         penyakitCf[penyakitId] = cf;
//       }
// // Normalisasi certainty factor dengan jumlah aturan
//       if (penyakitCf.keys.length == n) {
//         penyakitCf.forEach((key, value) {
//           penyakitCf[key] = value / n;
//         });
//       }
//     });

//     return penyakitCf;
//   }

//   Future<List<Question>> getQuestions() async {
//     List<Question> questions = [];
//     QuerySnapshot<Map<String, dynamic>> gejalaSnapshot =
//         await firestore.collection('gejala').get().catchError((error) {
//       print(error);
//     });
//     gejalaSnapshot.docs.forEach((gejalaDoc) {
//       Map<String, dynamic> gejala = gejalaDoc.data();
//       List<Answer> answers = [
//         Answer(answerText: 'Tidak', nilaiCf: 0.0),
//         Answer(answerText: 'Tidak Tahu', nilaiCf: 0.2),
//         Answer(answerText: 'Mungkin', nilaiCf: 0.4),
//         Answer(answerText: 'Kemungkinan Iya', nilaiCf: 0.6),
//         Answer(answerText: 'Iya', nilaiCf: 0.8),
//       ];
//       final namaGejala = gejala['namaGejala'];
//       questions.add(Question('Apakah anda mengalami $namaGejala', answers));
//     });

//     return questions;
//   }
// }

// class Diagnosis {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<List<Question>> getQuestion() async {
//     final gejalaRef = _firestore.collection('gejala');
//     final gejalaQuerySnapshot = await gejalaRef.get();
//     final List<Question> list = gejalaQuerySnapshot.docs.map((doc) {
//       final List<Answer> answerList = [
//         Answer(id: '1', answerText: 'Tidak', nilaiCf: 0),
//         Answer(id: '2', answerText: 'Tidak Tahu', nilaiCf: 0.2),
//         Answer(id: '3', answerText: 'Sedikit Yakin', nilaiCf: 0.4),
//         Answer(id: '4', answerText: 'Cukup Yakin', nilaiCf: 0.6),
//         Answer(id: '5', answerText: 'Yakin', nilaiCf: 0.8),
//       ];

//       final namaGejala =
//           doc.data().containsKey('namaGejala') ? doc['namaGejala'] : '';

//       return Question("Apakah Anda mengalami $namaGejala?", answerList);
//     }).toList();
//     return list;
//   }

//   Future<Map> hitungDiagnosa(List<Answer> jawabanList) async {
//     final faktorKepercayaanAwal = {};

//     // Mengambil data gejala dan menyimpannya dalam Map dengan key berupa idGejala
//     final gejalaQuerySnapshot =
//         await FirebaseFirestore.instance.collection('gejala').get();
//     final Map<String, Map<String, dynamic>> gejalaData = {};
//     gejalaQuerySnapshot.docs.forEach((doc) {
//       final idGejala = doc.id;
//       gejalaData[idGejala] = doc.data();
//     });

// // Mengambil data penyakit dan menyimpan faktor kepercayaan awal untuk setiap penyakit
//     final penyakitQuerySnapshot =
//         await FirebaseFirestore.instance.collection('penyakit').get();
//     penyakitQuerySnapshot.docs.forEach((doc) async {
//       final idPenyakit = doc.id;
//       final namaPenyakit = doc['namaPenyakit'];
//       final deskripsi = doc['deskripsi'];
//       final solusi = doc['solusi'];

// // Membuat list gejala-gejala yang berhubungan dengan penyakit tersebut
//       final gejalaPenyakit = [];
//       final aturanQuerySnapshot = await FirebaseFirestore.instance
//           .collection('aturan')
//           .where('penyakitId', isEqualTo: idPenyakit)
//           .get();

//       aturanQuerySnapshot.docs.forEach((aturanDoc) {
//         final idGejala = aturanDoc['gejalaId'];
//         final bobot = aturanDoc['bobot'];
//         final gejala = gejalaData[idGejala];
//         final gejalaJawaban =
//             jawabanList.firstWhere((jawaban) => jawaban.gejalaId == idGejala);
//         final jawaban = gejalaJawaban.jawaban;
// // Menghitung faktor kepercayaan setiap gejala berdasarkan jawaban pengguna
//         final faktorKepercayaan =
//             jawaban == null ? 0.0 : gejala!['cf'][jawaban];
//         final faktorKey = '$idPenyakit-$idGejala';
//         faktorKepercayaanAwal[faktorKey] = faktorKepercayaan * bobot;

// // Menambahkan gejala ke dalam list gejala-gejala penyakit
//         gejalaPenyakit.add(gejala);
//       });

// // Menghitung total bobot dan faktor kepercayaan setiap gejala
//       double cfAkhir = 0.0;
//       double totalBobot = 0.0;
//       faktorKepercayaanAwal.forEach((key, value) {
//         if (key.startsWith('$idPenyakit-')) {
//           cfAkhir += value;
//           totalBobot += gejalaData[key.split('-')[1]]!['bobot'];
//         }
//       });

// // Menghitung faktor kepercayaan akhir untuk penyakit tertentu
//       final cfAkhirPenyakit = cfAkhir / totalBobot;
//       print('Penyakit $namaPenyakit: $cfAkhirPenyakit');

// // Menyimpan hasil diagnosa dalam Map dan mengembalikannya
//       final result = {
//         'namaPenyakit': namaPenyakit,
//         'deskripsi': deskripsi,
//         'solusi': solusi,
//         'cf': cfAkhirPenyakit,
//       };
//       return result;
//     });
//   }
// }

// class Diagnosis {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   Map<String, double> penyakitMap = {};

//   Future<List<Question>> getQuestion() async {
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

//       return Question(
//           "Apakah Anda mengalami $namaGejala?",
//           answerList.map((answer) {
//             // Menyesuaikan nilaiCf berdasarkan jawaban yang dipilih
//             if (answer.answerText == 'Tidak') {
//               answer.nilaiCf = 0;
//             } else if (answer.answerText == 'Tidak Tahu') {
//               answer.nilaiCf = 0.2;
//             } else if (answer.answerText == 'Sedikit Yakin') {
//               answer.nilaiCf = 0.4;
//             } else if (answer.answerText == 'Cukup Yakin') {
//               answer.nilaiCf = 0.6;
//             } else if (answer.answerText == 'Yakin') {
//               answer.nilaiCf = 0.8;
//             }
//             return answer;
//           }).toList());
//     }).toList();
//     return list;
//   }

//   Future<Penyakit?> diagnose(List<String> selectedGejalaIds) async {
//     final penyakitRef = _firestore.collection('penyakit');
//     final aturanRef = _firestore.collection('aturan');
//     final penyakitQuerySnapshot = await penyakitRef.get();
//     final aturanQuerySnapshot = await aturanRef.get();

//     final penyakitList = penyakitQuerySnapshot.docs
//         .map((doc) => Penyakit(
//               namaPenyakit: doc['namaPenyakit'],
//               deskripsi: doc['deskripsi'],
//               solusi: doc['solusi'],
//             ))
//         .toList();

//     final aturanList = aturanQuerySnapshot.docs
//         .map((doc) => Aturan(
//               gejalaId: doc['gejalaId'],
//               penyakitId: doc['penyakitId'],
//               bobot: doc['bobot'].toDouble(),
//             ))
//         .toList();

//     final gejalaRef = _firestore.collection('gejala');
//     final gejalaQuerySnapshot = await gejalaRef.get();
//     final gejalaMap = Map.fromEntries(gejalaQuerySnapshot.docs
//         .map((doc) => MapEntry(doc.id, doc['nilaiCf'])));
//     final penyakitMap = <String, double>{};

// // Mencari penyakit yang sesuai dengan gejala yang dipilih
//     for (final penyakit in penyakitList) {
//       double cf = 1.0;
//       double totalBobot = 0;
//       for (final aturan in aturanList) {
//         if (selectedGejalaIds.contains(aturan.gejalaId) &&
//             penyakit.id == aturan.penyakitId) {
//           final bobot = aturan.bobot;
//           final gejalaId = aturan.gejalaId;

//           // Menghitung CF dari gejala
//           if (gejalaMap.containsKey(gejalaId)) {
//             cf = (bobot + (gejalaMap[gejalaId]! * (1 - bobot))) * cf;
//             totalBobot += bobot;
//           }
//         }
//       }

//       // Menambahkan penyakit dan nilai CF ke dalam penyakitMap
//       if (cf > 0) {
//         final persentaseBobot = totalBobot / penyakitList.length;
//         final nilaiAkhir = cf * persentaseBobot;
//         if (penyakitMap.containsKey(penyakit.id)) {
//           final currentCf = penyakitMap[penyakit.id]!;
//           penyakitMap[penyakit.id] = currentCf + (nilaiAkhir * (1 - currentCf));
//         } else {
//           penyakitMap[penyakit.id] = nilaiAkhir;
//         }
//       }
//     }

// // Mengurutkan hasil diagnosa berdasarkan nilai CF
//     final sortedPenyakitMap = penyakitMap.entries.toList()
//       ..sort((a, b) => b.value.compareTo(a.value));

// // Mengambil hasil diagnosa
//     final result = sortedPenyakitMap.isNotEmpty
//         ? penyakitList
//             .firstWhere((penyakit) => penyakit.id == sortedPenyakitMap[0].key)
//         : null;

//     return result;
//   }
// }

class Diagnosis {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Question>> getQuestion() async {
    final gejalaRef = _firestore.collection('gejala');
    final gejalaQuerySnapshot = await gejalaRef.get();

    final List<Question> list = gejalaQuerySnapshot.docs.map((doc) {
      final namaGejala =
          doc.data().containsKey('namaGejala') ? doc['namaGejala'] : '';
      final answerList = [
        Answer(answerText: 'Tidak', nilaiCf: 0),
        Answer(answerText: 'Tidak Tahu', nilaiCf: 0.2),
        Answer(answerText: 'Sedikit Yakin', nilaiCf: 0.4),
        Answer(answerText: 'Cukup Yakin', nilaiCf: 0.6),
        Answer(answerText: 'Yakin', nilaiCf: 0.8),
      ];

      return Question("Apakah Anda mengalami $namaGejala?", answerList);
    }).toList();

    return list;
  }

  Future<Map<String, double>> getResult(List<Answer> jawabanList) async {
    return await hitungDiagnosa(jawabanList);
  }

  Future<Map<String, double>> hitungDiagnosa(List<Answer> jawabanList) async {
    final penyakitRef = _firestore.collection('penyakit');
    final penyakitQuerySnapshot = await penyakitRef.get();

    final Map<String, double> faktorKepercayaanAwal = {};
    final Map<String, double> faktorKepercayaanTotal = {};

    penyakitQuerySnapshot.docs.forEach((doc) {
      final namaPenyakit =
          doc.data().containsKey('namaPenyakit') ? doc['namaPenyakit'] : '';
      final cf = doc.data().containsKey('faktorKepercayaan')
          ? doc['faktorKepercayaan']
          : 0.0;
      faktorKepercayaanAwal[namaPenyakit] = cf;
    });

    penyakitQuerySnapshot.docs.forEach((doc) {
      final namaPenyakit =
          doc.data().containsKey('namaPenyakit') ? doc['namaPenyakit'] : '';
      final gejalaList =
          doc.data().containsKey('gejalaList') ? doc['gejalaList'] : [];

      double cf = faktorKepercayaanAwal[namaPenyakit] ?? 0;

      gejalaList.forEach((gejala) {
        final idGejala = gejala['idGejala'];
        final jawaban = jawabanList.firstWhere(
          (jawaban) => jawaban.answerText == idGejala,
          orElse: () => Answer(answerText: '', nilaiCf: 0.0),
        );

        if (jawaban.answerText != '') {
          final bobot = gejala['bobot'];
          final indexJawaban = jawaban.nilaiCf;

          final cfGejala =
              (indexJawaban * bobot) + ((1 - bobot) * (1 - indexJawaban));
          cf = cf + (cfGejala * (1 - cf));
        }
      });

      faktorKepercayaanTotal[namaPenyakit] = cf;
    });

    final Map<String, double> penyakitMap = {};
    faktorKepercayaanAwal.forEach((namaPenyakit, cfAwal) {
      penyakitMap[namaPenyakit] = cfAwal;
    });
    faktorKepercayaanTotal.forEach((namaPenyakit, cfTotal) {
      final cfAwal = faktorKepercayaanAwal[namaPenyakit] ?? 0.0;
      final cfAkhir =
          (cfAwal * cfTotal) + ((1 - cfAwal) * penyakitMap[namaPenyakit]!);
      penyakitMap[namaPenyakit] = cfAkhir;
    });
    return penyakitMap;
  }
}
