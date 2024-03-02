import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Screens/home_screen.dart';
import '../reusable_widgets/reusable_widget.dart';
import 'OTPScreen.dart';

class PhoneLoginScreen extends StatefulWidget {
  const PhoneLoginScreen({super.key});

  @override
  State<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
  @override
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _phoneTextController = TextEditingController();
  String _errorMessage = '';
  Widget build(BuildContext context) {
    return Scaffold(body: isLoading ?
    Center(
      child: CircularProgressIndicator(),
    ) :Container(
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
              Text("Sign in using phone number",
                style: TextStyle(color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
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
                          return 'Please enter your mobile number';
                        }
                        return null;
                      },
                      controller: _phoneTextController,
                      style: TextStyle(color: Colors.black.withOpacity(0.9)),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                        prefixIcon: Icon(
                          Icons.phone_outlined,
                          color: Colors.red,
                        ),
                        labelText:"Enter mobile number",
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
                    loginButton(context, "Verify phone number", () {
                      isLoading = true;
                      String number = "+977" + _phoneTextController.text;
                      if(_formKey.currentState!.validate()){
                        FirebaseAuth.instance.verifyPhoneNumber(
                            verificationCompleted: (PhoneAuthCredential credential){},
                            verificationFailed: (FirebaseAuthException ex){
                              setState(() {
                                _errorMessage = ex.message.toString();
                              });
                            },
                            codeSent: (String verificationId, int? resendToken){
                              isLoading = false;
                              Navigator.push(context, MaterialPageRoute(builder: (context) => OTPScreen(verificationId: verificationId,)));
                            },
                            codeAutoRetrievalTimeout: (String verificationId){},
                            phoneNumber: number.toString());
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
