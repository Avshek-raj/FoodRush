import 'package:firebase_admin/firebase_admin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodrush/models/user_model.dart';
import 'package:foodrush/providers/user_provider.dart';
import 'package:foodrush/reusable_widgets/reusable_widget.dart';
import 'package:foodrush/login/signin_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_admin/firebase_admin.dart';


import '../Screens/home_screen.dart';
import '../Screens/Navigation.dart';
import 'emailVerification_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late UserProvider userProvider;
  final _formKey = new GlobalKey<FormState>();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _confirmPasswordTextController = TextEditingController();
  TextEditingController _usernameTextController = TextEditingController();
  TextEditingController _mobileNumTextController = TextEditingController();
  TextEditingController _addressTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of(context);
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
              const SizedBox(
                height:50
              ),
              Text("Sign Up",
                style: TextStyle(color: Colors.red, fontSize: 40, fontWeight: FontWeight.bold),
              ),
              Text("Add your details to sign up"),
              const SizedBox(
                height: 40,
              ),
              Form(
                  key: _formKey,
                  child: Column(

                  children:
                  [reusableTextFormField("Username", Icons.person_outline, "text", _usernameTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextFormField("Email", Icons.mail_outline, "email", _emailTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextFormField("Contact number", Icons.phone_outlined, "phone", _mobileNumTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextFormField("Address", Icons.home, "address", _addressTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextFormField("Password", Icons.lock_outline, "password", _passwordTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextFormField("Confirm Password", Icons.lock_outline, "password", _confirmPasswordTextController),],
              )),
              const SizedBox(
                height: 20,
              ),
              loginButton(context, "Sign Up", () {

                if (_formKey.currentState!.validate()) {
                  setState(() {
                    isLoading = true;
                  });
                  UserModel userModel = UserModel(
                    username: _usernameTextController.text,
                    email: _emailTextController.text,
                    phone: _mobileNumTextController.text,
                    address: _addressTextController.text,
                    password: _passwordTextController.text,
                    role: "User"
                  );
                  FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: _emailTextController.text,
                      password: _passwordTextController.text).then ((value) {
                    value.user?.sendEmailVerification();
                    userProvider.addUserDetails(
                        context: context,
                        username: _usernameTextController.text,
                        email: _emailTextController.text,
                        phone: _mobileNumTextController.text,
                        address: _addressTextController.text,
                        password: _passwordTextController.text,
                        role: "User",
                        onSuccess: (){
                          setState(() {
                            isLoading = false;
                          });
                          showDialog(context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Message"),
                                  content: Text("Verification link is sent to your email. Please verify before login"),
                                  actions: [
                                    TextButton(onPressed: (){
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => SignInScreen()));
                                    }, child: Text('OK'))
                                  ],
                                );
                              });
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
                  }).onError((error, stackTrace) async {
                    try{
                      if (error.toString() == "[firebase_auth/email-already-in-use] The email address is already in use by another account.") {

                        await FirebaseAdmin.instance.initializeApp(
                          AppOptions(
                            credential: FirebaseAdmin.instance.certFromPath("firebase-adminsdk-obpyz@foodrush-28b7a.iam.gserviceaccount.com"),
                          ),
                        );
                        var userRecord = await FirebaseAdmin.instance.app()?.auth().getUserByEmail(_emailTextController.text);
                        await FirebaseAdmin.instance.app()?.auth().deleteUser(userRecord!.uid);
                        await FirebaseAuth.instance.currentUser!.delete();
                        FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: _emailTextController.text,
                            password: _passwordTextController.text).then ((value) {
                          value.user?.sendEmailVerification();
                          userProvider.addUserDetails(
                              context: context,
                              username: _usernameTextController.text,
                              email: _emailTextController.text,
                              phone: _mobileNumTextController.text,
                              address: _addressTextController.text,
                              password: _passwordTextController.text,
                              role: "User",
                              onSuccess: (){
                                showDialog(context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Message"),
                                        content: Text("Verification link is sent to your email. Please verify before login"),
                                        actions: [
                                          TextButton(onPressed: (){
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (context) => SignInScreen()));
                                          }, child: Text('OK'))
                                        ],
                                      );
                                    });
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
                        }).onError((error, stackTrace) async {
                          setState(() {
                            isLoading = false;
                          });showDialog(context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Error"),
                                  content: Text(error.toString()),
                                  actions: [
                                    TextButton(onPressed: (){
                                      Navigator.of(context).pop();
                                    }, child: Text('OK'))
                                  ],
                                );
                              });
                          print("Error ${error.toString()}");
                        });
                      } else {
                        setState(() {
                          isLoading = false;
                        });
                        showDialog(context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Error"),
                                content: Text(error.toString()),
                                actions: [
                                  TextButton(onPressed: (){
                                    Navigator.of(context).pop();
                                  }, child: Text('OK'))
                                ],
                              );
                            });
                      }

                      print("Error ${error.toString()}");
                    }catch(e) {
                      setState(() {
                        isLoading = false;
                      });
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
                    }

                  });
                }
                //)
                // })
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
              loginOption(),
            ],
          ),
        )
      ),
    ));
  }

  Row loginOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account?",
            style: TextStyle(color: Colors.black)),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen()));
          },
          child: const Text(
            " Login",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
