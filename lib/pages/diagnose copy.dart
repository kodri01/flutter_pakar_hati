// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:pakar_hati/providers/database_service.dart';
// import 'package:pakar_hati/theme/color.dart';
// import '../models/model_pakar.dart';

// class Diagnose extends StatefulWidget {
//   static const routeName = '/diagnosis';

//   const Diagnose({Key? key}) : super(key: key);

//   @override
//   _DiagnoseState createState() => _DiagnoseState();
// }

// class _DiagnoseState extends State<Diagnose> {
//   final Diagnosis _diagnosis = Diagnosis();
//   int currentQuestionIndex = 0;
//   Answer? selectedAnswer;
//   List<Question> _questions = [];
//   List<Answer> answers = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadQuestions();
//   }

//   Future<void> _loadQuestions() async {
//     final questions = await _diagnosis.getQuestion();
//     if (questions.isNotEmpty) {
//       setState(() {
//         _questions = questions;
//       });
//     }
//   }

//   Widget _answerButton(Answer answer) {
//     bool isSelected = answer == selectedAnswer;

//     return Center(
//       child: Container(
//         width: 250,
//         height: 38,
//         margin: const EdgeInsets.symmetric(vertical: 3),
//         child: ElevatedButton(
//           onPressed: () {
//             setState(() {
//               selectedAnswer = answer;
//             });
//           },
//           style: ElevatedButton.styleFrom(
//             shape: const StadiumBorder(),
//             primary: isSelected ? thirdColor : secondaryColor,
//             onPrimary: isSelected ? Colors.white : backgroundColor,
//           ),
//           child: Text(
//             answer.answerText,
//             style: const TextStyle(fontSize: 18, fontFamily: 'Poppins'),
//             textAlign: TextAlign.center,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _answerList(List<Question> questions, int currentQuestionIndex) {
//     final answers = questions[currentQuestionIndex].answers;
//     return SizedBox(
//       height: 250,
//       child: ListView(
//         shrinkWrap: true,
//         children: answers.map<Widget>((answer) {
//           return _answerButton(answer);
//         }).toList(),
//       ),
//     );
//   }

//   Widget _nextButton(BuildContext context, List<Question> questions) {
//     bool isLastQuestion = currentQuestionIndex == questions.length - 1;
//     bool hasSelectedAnswer = selectedAnswer != null;

//     return Padding(
//       padding: const EdgeInsets.all(10),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           SizedBox(
//             width: MediaQuery.of(context).size.width * 0.3,
//             height: 40,
//             child: ElevatedButton(
//               onPressed: () async {
//                 if (isLastQuestion) {
//                   // Add the selected answer to the answers list
//                   if (selectedAnswer != null) {
//                     answers.add(selectedAnswer!);
//                   }

//                   // Process the diagnosis
//                   final result = await _diagnosis.hitungDiagnosa(answers);
//                   await FirebaseFirestore.instance
//                       .collection('users')
//                       .doc(DatabaseService(
//                               uid: FirebaseAuth.instance.currentUser!.uid)
//                           .uid)
//                       .collection('hasil_diagnosa')
//                       .add({
//                     'result': result,
//                     'timestamp': DateTime.now(),
//                   });

//                   // Go to the diagnosis result screen
//                   // Navigator.push(
//                   //   context,
//                   //   MaterialPageRoute(
//                   //     builder: (context) => DiagnosisResult(result: result),
//                   //   ),
//                   // );
//                 } else {
//                   // Add the selected answer to the answers list
//                   if (selectedAnswer != null) {
//                     answers.add(selectedAnswer!);
//                   }

//                   // Go to the next question
//                   setState(() {
//                     currentQuestionIndex++;
//                   });
//                 }
//               },
//               style: ElevatedButton.styleFrom(
//                 shape: const StadiumBorder(),
//                 primary: isLastQuestion
//                     ? (hasSelectedAnswer ? primaryColor : Colors.grey)
//                     : secondaryColor,
//                 onPrimary: Colors.white,
//               ),
//               child: Text(
//                 isLastQuestion ? "Submit" : "Next",
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w700,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_questions.isEmpty) {
//       // Tampilkan widget loading atau indikator lainnya jika _questions masih kosong
//       return const Center(
//         child: CircularProgressIndicator(),
//       );
//     } else {
//       return Scaffold(
//         appBar: AppBar(
//           title: const Text('My Diagnosis'),
//         ),
//         body: SafeArea(
//           child: Column(
//             children: [
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.all(10),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // const SizedBox(height: 10),
//                       Text(
//                         "Questions ${currentQuestionIndex + 1}/${_questions.length.toString()}",
//                         style: const TextStyle(
//                           fontFamily: 'Poppins',
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18,
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       Container(
//                         width: double.infinity,
//                         alignment: Alignment.center,
//                         child: Padding(
//                           padding: const EdgeInsets.all(4.0),
//                           child: Text(
//                             _questions[currentQuestionIndex].questionText,
//                             textAlign: TextAlign.center,
//                             style: const TextStyle(
//                               fontFamily: 'Poppins',
//                               fontSize: 17,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                       ),
//                       _answerList(_questions, currentQuestionIndex),
//                     ],
//                   ),
//                 ),
//               ),
//               _nextButton(context, _questions),
//             ],
//           ),
//         ),
//       );
//     }
//   }
// }
