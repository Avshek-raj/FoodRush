import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodrush/login/phoneLogin_screen.dart';
import 'package:foodrush/login/signup_screen.dart';
import 'package:foodrush/reusable_widgets/reusable_widget.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Screens/home_screen.dart';
import '../Screens/Navigation.dart';
import '../restaurantScreens/navbarRestaurant.dart';
import '../utils/color_utils.dart';

class RestaurantSignInScreen extends StatefulWidget {
  const RestaurantSignInScreen({super.key});

  @override
  State<RestaurantSignInScreen> createState() => _RestaurantSignInScreenState();
}

class _RestaurantSignInScreenState extends State<RestaurantSignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final passController = TextEditingController();
  bool passToggle = false;
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: FirebaseAuth.instance.currentUser != null ? MainScreen()
        :isLoading ?
    Center(
      child: CircularProgressIndicator(),
    ) :Container(
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
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (value){
                              if (value!.isEmpty){
                                return 'Please enter a username';
                              }
                              return null;
                            },
                            controller: _emailTextController,
                            style: TextStyle(color: Colors.black.withOpacity(0.9)),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                              prefixIcon: Icon(
                                Icons.person_outline,
                                color: Colors.red,
                              ),
                              labelText:"Enter username or number",
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
                          TextFormField(
                            obscureText: !passToggle,
                            controller: _passwordTextController,
                            validator: (value) {
                              if (value!.isEmpty){
                                return "Please enter your password";
                              } else if(value.length <=7) {
                                return "The password should be at least 8 characters";
                              }
                            },
                            style: TextStyle(color: Colors.black.withOpacity(0.9)),
                            decoration: InputDecoration(
                              
                              contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: Colors.red,
                              ),
                              suffix: InkWell(
                                onTap: () {
                                  setState(() {
                                    passToggle = !passToggle;
                                  });
                                },
                                child: Icon(passToggle? Icons.visibility: Icons.visibility_off, color: Colors.red,),
                              ),
                              labelText:"Enter password",
                              labelStyle: TextStyle(color: Colors.grey.withOpacity(0.9)),
                              filled: false,
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              //fillColor: Colors.white.withOpacity(0.3),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(color: Colors.red,)),
                                    focusedBorder: OutlineInputBorder(
            // Set focused border color to red
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(color: Colors.red),
          ),
                            ),
                            keyboardType: passToggle ?TextInputType.text: TextInputType.visiblePassword,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          //
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("Forgot Password?"),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          loginButton(context, "Login", () {
                            String username = _emailTextController.text;
                            String password = _passwordTextController.text;
                            if(_formKey.currentState!.validate()){
                              setState(() {
                                isLoading = true;
                              });
                              if (username == 'admin' && password == 'admin'){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => NavbarRestaurant()));
                              }
                              FirebaseAuth.instance.signInWithEmailAndPassword(
                                  email: _emailTextController.text,
                                  password: _passwordTextController.text).then ((value) {
                                print(value.toString());
                                Navigator.push(context, MaterialPageRoute(builder: (context) => NavbarRestaurant()));
                              }).onError((error, stackTrace) {
                                setState(() {
                                  isLoading =false;
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
                              });
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
                        ],
                      )
                  ),
                  //
                  // signUpOption(),
                  const SizedBox(
                      height:20
                  ),
                  dividerOrLine(),
                  const SizedBox(
                      height:20
                  ),
                  // loginWith(),
                  Text("Don't have an account?"),
                  const SizedBox(
                      height:20
                  ),
                  loginButton(context, "Register your Restaurant", () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));

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
        SizedBox(height:20),
        const Text("Login with ",
            style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold, fontSize: 18)),
        SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: (){},
              child: Image.asset(
                "assets/images/google.png", // Replace with your Google logo asset
                height: 35.0,
              ),
            ),
            SizedBox(width: 20,),
            InkWell(
              onTap: (){},
              child: Image.asset(
                "assets/images/facebook.png", // Replace with your Google logo asset
                height: 35.0,
              ),
            ),
          ],
        )
      ],
    );
  }
}


