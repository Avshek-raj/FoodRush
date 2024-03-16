import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodrush/login/forgotPw2.dart';
import 'package:foodrush/ui_custom/TextFormCus.dart';
import 'package:foodrush/utils/color_utils.dart';

String? phoneNumber = "";
String? phoneCode = "+977";

class ForgotPw1 extends StatefulWidget {
  const ForgotPw1({super.key});

  @override
  State<ForgotPw1> createState() => _ForgotPw1State();
}

class _ForgotPw1State extends State<ForgotPw1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//       appBar: AppBar(title: Text( "Forgot Password?",style: TextStyle(
// fontWeight: FontWeight.bold,
// fontSize: 20,

//       ),),),

      body: Column(children: [
        SizedBox(
          height: 50,
        ),
        Text(
          "Forgot Password?",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        SizedBox(
          height: 100,
        ),

        Text(
          "Enter your phone number to receive your 6 digit OTP code",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Ctextform(
            keyboardType:
                TextInputType.phone, //number matra keyboard ma dekhauna
            labelText: phoneStr,
            prefixIcon: Icon(
              Icons.phone_iphone_rounded,
              color: Colors.red,
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Please enter your phone number to receive OTP code";
              } else {
                return null;
              }
            },
            onChanged: (value) {
              phoneNumber = value;
            },
          ),
        ),
        //button
        SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 50,
          width: 250,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                sendVerificationCode(context);
              },
              child: Text("next")),
        ),
      ]),
    );
  }
}

//submit button thiche paxi yo function run hunxa
sendVerificationCode(BuildContext context) async {
  await FirebaseAuth.instance.verifyPhoneNumber(
    phoneNumber: phoneCode! + phoneNumber!, //user lai phone no pathauna ko lagi
    verificationCompleted: (PhoneAuthCredential credential) {},
    verificationFailed: (FirebaseAuthException e) {},
    codeSent: (String verificationId, int? resendToken) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ForgotPw2(
                    phoneNumber: phoneNumber,
                    verificationId: verificationId,
                  )));
    },
    codeAutoRetrievalTimeout: (String verificationId) {},
  );
}
