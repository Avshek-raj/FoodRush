import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../reusable_widgets/reusable_widget.dart';
import 'home_screen.dart';

class OTPScreen extends StatefulWidget {
  String verificationId;
  OTPScreen({super.key, required this.verificationId});
  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  @override
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _otpController = TextEditingController();
  String _errorMessage = '';
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height * 0.02, 20, 0),
          child: Column(
            children: <Widget>[
              logoWidget("assets/images/logo_pureRed.png"),
              const SizedBox(
                  height:50
              ),
              Text("Enter the OTP sent to your mobile number",
                style: TextStyle(color: Colors.red, fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                  height:20
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value){
                          if (value!.isEmpty){
                            return 'Enter the OTP';
                          }
                          return null;
                        },
                        controller: _otpController,
                        style: TextStyle(color: Colors.black.withOpacity(0.9)),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                          prefixIcon: Icon(
                            Icons.password_outlined,
                            color: Colors.red,
                          ),
                          labelText:"Enter the OTP",
                          labelStyle: TextStyle(color: Colors.grey.withOpacity(0.9)),
                          filled: false,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          //fillColor: Colors.white.withOpacity(0.3),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide(color: Colors.black,)),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      loginButton(context, "Verify OTP", () async {
                        if(_formKey.currentState!.validate()){
                          try {
                            PhoneAuthCredential credential = await PhoneAuthProvider.credential(verificationId: widget.verificationId, smsCode: _otpController.text.toString());
                            FirebaseAuth.instance.signInWithCredential(credential).then((value) {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                            }).onError((error, stackTrace) {
                              setState(() {
                                _errorMessage = 'Incorrect OTP code. Please try again.';
                              });
                              print("Error ${error.toString()}");
                            });
                          } catch (ex) {
                            log(ex.toString());
                          }
                        }
                        // FirebaseAuth.instance
                        //     .signInWithEmailAndPassword(
                        //     email: _emailTextController.text,
                        //     password: _passwordTextController.text)
                        //     .then((value) {
                        //   Navigator.push(context,
                        //       MaterialPageRoute(builder: (context) => HomeScreen()));
                        // }).onError((error, stackTrace) {
                        //   print("Error ${error.toString()}");
                        // });
                      }),
                      _errorMessage.isNotEmpty
                          ? Text(
                        _errorMessage,
                        style: TextStyle(color: Colors.red),
                      )
                          : SizedBox.shrink(),
                    ],
                  )
              )
            ],
          ),
        ),
      ),
    ),);
  }
}
