import 'package:flutter/material.dart';

class SignUpRestaurant extends StatefulWidget {
  const SignUpRestaurant({super.key});

  @override
  State<SignUpRestaurant> createState() => _SignUpRestaurantState();
}

class _SignUpRestaurantState extends State<SignUpRestaurant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: SingleChildScrollView(
  child: SafeArea(
    child: Column(
      children: [
           Container(
                      // height: MediaQuery.of(context).size.height * 0.25,
                      // width: MediaQuery.of(context).size.width * 0.99,
                      
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        // borderRadius: BorderRadius.circular(14),
                        // border: Border.all(color: Colors.grey),
                      ),
                      // child: ClipRRect(
                      //   borderRadius: BorderRadius.circular(14),
                      //   // child: Image.asset("assets/images/vtrLogo.png",
                      //   // height: 200,
                      //   // width: 200,
                      //   // fit: BoxFit.fill,
                      //   // ),
                      // ),s
                      // alignment: Alignment.center,
                    ),
      ],
    ),
  ),
),
    );
  }
}