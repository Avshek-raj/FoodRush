import 'package:flutter/material.dart';
import 'package:foodrush/reusable_widgets/reusable_widget.dart';
import 'package:foodrush/screens/signin_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _confirmPasswordTextController = TextEditingController();
  TextEditingController _usernameTextController = TextEditingController();
  TextEditingController _mobileNumTextController = TextEditingController();
  TextEditingController _addressTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
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
              //logoWidget("assets/images/logo_pureRed.png"),
              reusableTextField("username", Icons.person_outline, "text", _usernameTextController),
              const SizedBox(
                height: 20,
              ),
              reusableTextField("Email", Icons.mail_outline, "email", _emailTextController),
              const SizedBox(
                height: 20,
              ),
              reusableTextField("Mobile No.", Icons.phone_outlined, "phone", _mobileNumTextController),
              const SizedBox(
                height: 20,
              ),
              reusableTextField("Address", Icons.home, "address", _addressTextController),
              const SizedBox(
                height: 20,
              ),
              reusableTextField("Password", Icons.lock_outline, "password", _passwordTextController),
              const SizedBox(
                height: 20,
              ),
              reusableTextField("Confirm Password", Icons.lock_outline, "password", _confirmPasswordTextController),const SizedBox(
                height: 20,
              ),
              loginButton(context, "Sign Up", () {
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
