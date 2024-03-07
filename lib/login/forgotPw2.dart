import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodrush/login/signin_screen.dart';
import 'package:pinput/pinput.dart';

class ForgotPw2 extends StatefulWidget {
  String? verificationId, phoneNumber;
  ForgotPw2({super.key, this.phoneNumber, this.verificationId});

  @override
  State<ForgotPw2> createState() => _ForgotPw2State();
}

class _ForgotPw2State extends State<ForgotPw2> {
  String? code = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    BackButton(
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    // Spacer(),
                    Text(
                      "Forgot Password",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                "We have sent six digit code to ${widget.phoneNumber}",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              ),
              // Text("Verify",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              // Text("Your code has been sent to you via your phone number"),
              Text(
                "Please enter the pin",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Pinput(
                  length: 6,
                  onCompleted: (value) {
                    code = value;
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              //code naaako bela ma
              
              Column(
                children: [
                  Text(
                    "Didn't Receive the Code?",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15,color: Colors.grey.shade400),
                  ),
                  Text(
                    "Resend Code",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                ],
              ),

              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                width: 250,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      onPrimary: Colors.white,
                      primary: Colors.red,
                    ),
                    onPressed: () {
                      otpVerification();
                    },
                    child: Text("Submit")),
              )
            ],
          ),
        ),
      ),
    );
  }

  //user le haleko otp ra firebase le deko otp milxa mildaina check garna lai
  otpVerification() async {
    try {
      //yedi milyo vane try ma kaam sakxa natra catch ma xirxa
      String smsCode = code!; //yaha user le box ma j code lekhxa tye aauxa

      // Create a PhoneAuthCredential with the code
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: widget.verificationId!, smsCode: smsCode);

      // Sign the user in (or link) with the credential
      await FirebaseAuth.instance.signInWithCredential(
          credential); //credential thik xa ya xaina verify garxa
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SignInScreen()));
    } catch (e) {
      print("invalid OTP");
    }
  }
}
