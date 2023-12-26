import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodrush/reusable_widgets/reusable_widget.dart';
import 'package:foodrush/screens/signup_screen.dart';

import '../utils/color_utils.dart';
import 'home_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      // decoration: BoxDecoration(
      //     gradient: LinearGradient(colors: [
      //       hexStringToColor("#FF3333"),
      //       hexStringToColor("#FF3933"),
      //       hexStringToColor("#FF5733")
      //     ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            20, MediaQuery.of(context).size.height * 0.02, 20, 0),
          child: Column(
            children: <Widget>[
              logoWidget("assets/images/logo_pureRed.png"),
              // const SizedBox(
              //   height: 30,
              // ),
              reusableTextField("Enter Username/Email", Icons.person_outline, "",
                  _emailTextController),
              const SizedBox(
                height: 20,
              ),
              reusableTextField("Enter Password", Icons.lock_outline, "password",
                  _passwordTextController),
              const SizedBox(
                height: 20,
              ),
              loginButton(context, "Login", () {
                String username = _emailTextController.text;
                String password = _passwordTextController.text;
                  if (username == 'admin' && password == 'admin'){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => homeScreen()));
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
              signUpOption(),
              const SizedBox(
                height:20
              ),
              dividerOrLine(),
              const SizedBox(
                  height:20
              ),
              //loginWith(),
              customLoginButton(context, "Login with Google", () {
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
              customLoginButton(context, "Login with Facebook", () {
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
            ]
          ),

        )
      ),
    ));
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?",
            style: TextStyle(color: Colors.black)),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            " Sign up",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Row showCustomLogin(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
            },
            child: const Text(
              " Google",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            " Facebook",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Column loginWith() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        dividerOrLine(),
        const Text("Login with ",
            style: TextStyle(color: Colors.black)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("G ",style: TextStyle(color: Colors.black)),
            const Text("M ",style: TextStyle(color: Colors.black)),
        ],
        )
      ],
    );
  }
}


