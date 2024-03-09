import 'package:flutter/material.dart';
import 'package:foodrush/login/signin_screen.dart';
import 'package:foodrush/ui_custom/TextFormCus.dart';
// Import your login page

class PWChange extends StatefulWidget {
  const PWChange({Key? key}) : super(key: key);

  @override
  State<PWChange> createState() => _PWChangeState();
}

class _PWChangeState extends State<PWChange> {
  bool showPassword = false; // State variable to track password visibility
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // Form key for validation

  String? newPassword;
  String? confirmNewPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey, // Assigning the form key
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
                        "Forgot Password",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                // Textform for change pw
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Ctextform(
                    labelText: "New Password",
                    obscureText:
                        !showPassword, // Use !showPassword to determine obscureText
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: Colors.red,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter Your New Password";
                      } else if (value.length < 8) {
                        return "Password length should be at least 8";
                      } else {
                        newPassword = value;
                        return null;
                      }
                    },
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Ctextform(
                    labelText: "Confirm New Password",
                    obscureText:
                        !showPassword, // Always obscure the confirm password field
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: Colors.red,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please re-enter your New Password";
                      } else if (value != newPassword) {
                        return "Passwords does not match";
                      } else if (value.length < 8) {
                        return "Password length should be at least 8";
                      } else {
                        confirmNewPassword = value;
                        return null;
                      }
                    },
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Checkbox(
                        activeColor: Colors.red,
                        value: showPassword,
                        onChanged: (value) {
                          setState(() {
                            showPassword = value!;
                          });
                        },
                      ),
                      Text("Show Password"), // Label for the checkbox
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
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
                      if (_formKey.currentState!.validate()) {
                        // If form is valid, navigate to the login page and show dialog
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInScreen()),
                        );
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Success!"),
                              content: Text("Password changed successfully"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "OK",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: Text("Submit"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
