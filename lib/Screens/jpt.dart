import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class _jpState extends StatefulWidget {
  const _jpState({super.key});

  @override
  State<_jpState> createState() => __jpStateState();
}

class __jpStateState extends State<_jpState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: Column(
  children: [
     // Container(
              //   child: ToggleButtons(children: [
              //     SizedBox(
              //       width: MediaQuery.of(context).size.width*0.45,
              //       child: Center(child: Text("Meals"),),
              //     ),
              //     SizedBox(
              //       width: MediaQuery.of(context).size.width*0.45,
              //       child: Center(child: Text("Sides"),),
              //     ),
              //     // SizedBox(
              //     //   width: MediaQuery.of(context).size.width*0.45,
              //     //   child: Center(child: Text("Snacks"),),
              //     // ),
              //   ], isSelected:  isSelected,
              //         fillColor: Colors.red,
              //         color: Colors.black,
              //         selectedColor: Colors.white,
              //         borderRadius: BorderRadius.circular(20),
              //         onPressed: (index) {
              //           for (int i = 0; i < isSelected.length; i++) {
              //             if (index == i) {
              //               isSelected[i] = true;
              //             } else {
              //               isSelected[i] = false;
              //             }
              //             setState(() {
              //               isSelected;
              //             });
              //           }
              //           if (index == 1) {
              //             pageController.nextPage(
              //                 duration: Duration(milliseconds: 200),
              //                 curve: Curves.easeInOut);
              //           } else {
              //             pageController.previousPage(
              //                 duration: Duration(milliseconds: 200),
              //                 curve: Curves.easeInOut);
              //           }
              //           setState(() {
              //             isSelected;
              //             pageController;
              //           });
              //         },),
              // ),
              
  ],
),

    );
  }
}