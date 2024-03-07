// import 'package:flutter/material.dart';
// import 'package:foodrush/ui_custom/TextFormCus.dart';
// import 'package:foodrush/ui_custom/customElevatedButton.dart';
// import 'package:foodrush/utils/color_utils.dart';

// class PwChange extends StatefulWidget {
//   const PwChange({super.key});

//   @override
//   State<PwChange> createState() => _PwChangeState();
// }

// class _PwChangeState extends State<PwChange> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: Row(
//                   children: [
//                     BackButton(
//                       color: Colors.black,
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     // Spacer(),
//                     Text(
//                       "Settings",
//                       style:
//                           TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
//                     ),
//                   ],
//                 ),
//               ),
//               //restaurant owner le change garna ko lagi
            
//                 Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10),
//                 child: Ctextform(
//                   labelText: "Current Password",
//                   suffixIcon: Icon(
//                     Icons.visibility_off,
//                     color: Colors.red,
//                   ),
//                       obscureText: true, 

//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return passwordValidatorStr;
//                     } else {
//                       return null;
//                     }
//                   },
//                   onChanged: (value) {},
//                 ),
//               ),
//               SizedBox(height: 10,),
//                 Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10),
//                 child: Ctextform(
//                   labelText: "New Password",
//                   suffixIcon: Icon(
//                     Icons.visibility_off,
//                     color: Colors.red,
//                   ),
//                       obscureText: true, 

//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return passwordValidatorStr;
//                     } else {
//                       return null;
//                     }
//                   },
//                   onChanged: (value) {},
//                 ),
//               ),
//                             SizedBox(height: 10,),

//                 Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10),
//                 child: Ctextform(
//                   labelText: "Confirm Password",
//                   suffixIcon: Icon(
//                     Icons.visibility_off,
//                     color: Colors.red,
//                   ),
//                       obscureText: true, 

//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return passwordValidatorStr;
//                     } else {
//                       return null;
//                     }
//                   },
//                   onChanged: (value) {},
//                 ),
//               ),
//                             SizedBox(height: 10,),
//                             CustomElevatedButton(label: "hi", onPressed: (){

//                             }, child: Text("Submit"))

//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
