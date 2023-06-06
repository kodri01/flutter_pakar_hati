// import 'package:flutter/material.dart';
// import 'package:pakar_hati/providers/model_knowladge.dart';
// import 'package:pakar_hati/theme/color.dart';

// class Diagnosa extends StatefulWidget {
//   const Diagnosa({super.key});

//   @override
//   State<Diagnosa> createState() => _DiagnosaState();
// }

// class _DiagnosaState extends State<Diagnosa> {
//   List<Question> questionList = getQuestion();
//   int CurrentQuestionIndex = 0;
//   Answer? selectedAnswer;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: secondaryColor,
//         appBar: AppBar(
//             backgroundColor: secondaryColor,
//             iconTheme: IconThemeData(color: primaryTextColor),
//             elevation: 0,
//             automaticallyImplyLeading: true,
//             title: const Text("Diagnosa Penyakit",
//                 style: TextStyle(
//                     color: primaryTextColor,
//                     fontFamily: 'Poppins',
//                     fontSize: 22,
//                     fontWeight: FontWeight.w500))),
//         body: SafeArea(
//           child: GestureDetector(
//             onTap: () => FocusScope.of(context).unfocus(),
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.max,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Padding(
//                     padding:
//                         const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
//                     child: Card(
//                       clipBehavior: Clip.antiAliasWithSaveLayer,
//                       elevation: 10,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.max,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisSize: MainAxisSize.max,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Image.asset(
//                                 'assets/heart.png',
//                                 width: 170,
//                                 height: 100,
//                                 fit: BoxFit.fill,
//                               ),
//                               const Text(
//                                 'Pilih jawaban sesuai \ndengan kondisi yang anda\nalami saat ini.',
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   fontFamily: 'Poppins',
//                                   fontSize: 13,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Container(
//                             width: double.infinity,
//                             height: 5,
//                             decoration: BoxDecoration(
//                               color: secondaryColor,
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                           ),
//                           _questionWidget(),
//                           _answerList(),
//                           _nextButton(),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ));
//   }

//   _questionWidget() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             "Question ${CurrentQuestionIndex + 1}/${questionList.length.toString()}",
//             style: const TextStyle(
//               color: Colors.black,
//               fontSize: 20,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//         const SizedBox(
//           height: 10,
//         ),
//         Container(
//           width: double.infinity,
//           alignment: Alignment.center,
//           child: Padding(
//             padding: const EdgeInsets.all(4.0),
//             child: Text(
//               questionList[CurrentQuestionIndex].questionText,
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 color: Colors.black,
//                 fontSize: 20,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(
//           height: 20,
//         ),
//       ],
//     );
//   }

//   _answerList() {
//     return Expanded(
//       child: ListView(
//         shrinkWrap: true,
//         children: questionList[CurrentQuestionIndex]
//             .answerList
//             .map(
//               (e) => _answerButton(e),
//             )
//             .toList(),
//       ),
//     );
//   }

//   _nextButton() {
//     bool isLastQuestion = false;
//     if (CurrentQuestionIndex == questionList.length - 1) {
//       isLastQuestion = true;
//     }
//     return Padding(
//       padding: const EdgeInsets.all(12),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           SizedBox(
//             width: MediaQuery.of(context).size.width * 0.3,
//             height: 40,
//             child: ElevatedButton(
//               onPressed: () {
//                 if (isLastQuestion) {
//                   //display result
//                 } else {
//                   //next question
//                   setState(() {
//                     selectedAnswer = null;
//                     CurrentQuestionIndex++;
//                   });
//                 }
//               },
//               style: ElevatedButton.styleFrom(
//                 shape: const StadiumBorder(),
//                 primary: thirdColor,
//                 onPrimary: backgroundColor,
//               ),
//               child: Text(
//                 isLastQuestion ? "Submit" : "Next",
//                 style: TextStyle(
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
//             style: TextStyle(fontSize: 18, fontFamily: 'Poppin'),
//             textAlign: TextAlign.center,
//           ),
//         ),
//       ),
//     );
//   }
// }
