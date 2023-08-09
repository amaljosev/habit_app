// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class ScreenHelp extends StatefulWidget {
//   const ScreenHelp({super.key});

//   @override
//   State<ScreenHelp> createState() => _ScreenHelpState();
// }

// class _ScreenHelpState extends State<ScreenHelp> {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.separated(
//         itemBuilder: (context, index) {
//           return InkWell(
//             child: Card(
//               color: Colors.indigo.shade50,
//               child: ExpansionTile(
//                 title: Text(
//                   questionList[index],
//                 ), 
                
//               ),
//             ),
//           );
//         },
//         separatorBuilder: (context, index) {
//           return const SizedBox(
//             height: 5,
//           );
//         },
//         itemCount: questionList.length);
//   }

//   List questionList = [
//     'What is your refund policy?',
//     'What is your refund policy?',
//     'What is your refund policy?',
//     'What is your refund policy?',
//     'What is your refund policy?'
//   ];

// }
