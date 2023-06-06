// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import '../models/model_pakar.dart';

// class Diagnosa extends StatefulWidget {
//   const Diagnosa({Key? key}) : super(key: key);

//   @override
//   _DiagnosaState createState() => _DiagnosaState();
// }

// class _DiagnosaState extends State<Diagnosa> {
//   final Diagnosis _diagnosis = Diagnosis();
//   List<Question> _questions = [];
//   final List<Answer> _answers = [];
//   int _questionIndex = 0;
//   bool _isLoading = true;
//   String _result = '';

//   @override
//   void initState() {
//     super.initState();
//     _getQuestions();
//   }

//   Future<void> _getQuestions() async {
//     try {
//       _questions = await _diagnosis.getQuestion();
//       setState(() {
//         _isLoading = false;
//       });
//     } catch (error) {
//       print(error);
//     }
//   }

//   void _answerQuestion(String answerText, double nilaiCf) {
//     if (_questionIndex == _questions.length - 1) {
//       _showResult();
//     } else {
//       setState(() {
//         _answers.add(Answer(answerText: answerText, nilaiCf: nilaiCf));
//         _questionIndex++;
//       });
//     }
//   }

//   Future<void> _showResult() async {
//     setState(() {
//       _isLoading = true;
//     });

//     final result = await _diagnosis.hitungDiagnosa(_answers);
//     _result = _calculateResult(result);

//     setState(() {
//       _isLoading = false;
//     });

//     // Menampilkan hasil diagnosa
//     showDialog(
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//         title: Text('Hasil Diagnosa'),
//         content: Text(_result),
//         actions: <Widget>[
//           TextButton(
//             child: Text('Tutup'),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//         ],
//       ),
//     );
//   }

//   String _calculateResult(Map<String, double> result) {
//     double maxCf = 0;
//     String maxPenyakit = '';
//     result.forEach((penyakitId, cf) {
//       if (cf > maxCf) {
//         maxCf = cf;
//         maxPenyakit = penyakitId;
//       }
//     });

//     return maxCf == 0
//         ? 'Maaf, tidak ada penyakit yang cocok dengan gejala yang Anda alami'
//         : 'Anda mungkin menderita penyakit $maxPenyakit dengan tingkat keyakinan ${maxCf.toStringAsFixed(2)}';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Diagnosis Penyakit'),
//       ),
//       body: _isLoading
//           ? const SpinKitFadingCircle(
//               color: Colors.blue,
//               size: 50.0,
//             )
//           : _questions.isNotEmpty
//               ? Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         _questions[_questionIndex].questionText,
//                         style: const TextStyle(
//                           fontSize: 20.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 16.0),
//                       Column(
//                         children: _questions[_questionIndex]
//                             .answers
//                             .map(
//                               (answer) => Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                   vertical: 8.0,
//                                 ),
//                                 child: ElevatedButton(
//                                   onPressed: () => _answerQuestion(
//                                     answer.answerText,
//                                     answer.nilaiCf,
//                                   ),
//                                   child: Text(answer.answerText),
//                                 ),
//                               ),
//                             )
//                             .toList(),
//                       ),
//                       const SizedBox(height: 16.0),
//                       if (_result.isNotEmpty)
//                         Text(
//                           _result,
//                           style: const TextStyle(
//                             fontSize: 18.0,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                     ],
//                   ),
//                 )
//               : Center(
//                   child: Text(
//                     'Tidak ada pertanyaan',
//                     style: TextStyle(
//                       fontSize: 18.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//     );
//   }
// }
