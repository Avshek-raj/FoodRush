import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodrush/providers/user_provider.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import '../Screens/Navigation.dart';
import '../models/user_model.dart';
import 'signin_screen.dart';

class EmailVerificationScreen extends StatefulWidget {
  final User? user;
  final String? verificationId;
  UserModel? userModal ;
  EmailVerificationScreen({Key? key, this.user, this.userModal, this.verificationId}) : super(key: key);

  @override
  _EmailVerificationScreenState createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  late UserProvider userProvider;
  String? code = "";
  String _errorMessage = "";
  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of(context);
    return Scaffold(
      body: SafeArea(
        child: Builder(
          builder: (BuildContext scaffoldContext) {
            return SingleChildScrollView(
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
                        Text(
                          "Email verification",
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
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
                    "We have sent a six-digit code to ${widget.user?.email}",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
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
                  Column(
                    children: [
                      Text(
                        "Didn't Receive the Code?",
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15,color: Colors.grey.shade400),
                      ),
                      GestureDetector(
                        child: Text("Resend" ,style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),),
                        onTap: () async{
                          await widget.user?.sendEmailVerification();
                          ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                            SnackBar(
                              content: Text('Verification code sent to ${widget.user?.email}'),
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.symmetric(horizontal: 20),
                            ),
                          );
                        },
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
                        foregroundColor: Colors.white, backgroundColor: Colors.red,
                      ),
                      onPressed: () {
                        verifyEmailOTP(widget.user!.email!, code!).then((_){
                          ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                            SnackBar(
                              content: Text('Emaail verified successfully'),
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.symmetric(horizontal: 20),
                            ),
                          );
                          userProvider.addUserDetails(
                              context: context,
                              username: widget.userModal?.username,
                              email: widget.userModal?.email,
                              phone: widget.userModal?.phone,
                              address: widget.userModal?.address,
                              password: widget.userModal?.password,
                              role: widget.userModal?.role,
                              onSuccess: (){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => MainScreen()));
                              },
                              onError: (e){
                                showDialog(context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Error"),
                                        content: Text(e.toString()),
                                        actions: [
                                          TextButton(onPressed: (){
                                            Navigator.of(context).pop();
                                          }, child: Text('OK'))
                                        ],
                                      );
                                    });
                              });

                        }).catchError((error) {
                          setState(() {
                            _errorMessage = "The OTP code in invalid.";
                          });
                        });
                      },
                      child: Text("Submit"),
                    ),
                  ),
                  _errorMessage.isNotEmpty
                      ? Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red),
                  )
                      : SizedBox.shrink(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> verifyEmailOTP(String email, String verificationCode) async {
    try {
      // Use the applyActionCode method to apply the email verification code
      await FirebaseAuth.instance.applyActionCode(verificationCode);

      // Once the code is applied successfully, reload the user to update the email verification status
      await FirebaseAuth.instance.currentUser!.reload();

      // Check if the email is verified
      if (FirebaseAuth.instance.currentUser!.emailVerified) {
        // Email is verified
        print('Email verified successfully for $email');
      } else {
        // Email is not verified
        print('Email verification failed for $email');
      }
    } catch (error) {
      // Handle any errors that occur during the verification process
      print('Failed to verify email with code: $error');
    }
  }
}
