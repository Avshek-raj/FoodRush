import 'package:flutter/material.dart';

class Ctextform extends StatefulWidget {
  bool obscureText;
  String? labelText;
  String? Function(String?)? validator;
  Widget? suffixIcon;
  Widget? prefixIcon;
  Function(String)? onChanged;
  TextInputType? keyboardType; // Make keyboardType nullable

  // Modify the constructor to make keyboardType optional without default value
  Ctextform({
    Key? key,
    this.validator,
    this.suffixIcon,
    this.prefixIcon,
    this.labelText,
    this.obscureText = false,
    this.onChanged,
    this.keyboardType, // Make keyboardType optional
  }) : super(key: key);

  @override
  _CtextformState createState() => _CtextformState();
}

class _CtextformState extends State<Ctextform> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          _isFocused = hasFocus;
        });
      },
      child: TextFormField(
        keyboardType: widget.keyboardType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: widget.validator,
        onChanged: widget.onChanged,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 16), // Adjust vertical padding
          labelText: widget.labelText,
          labelStyle: TextStyle(
            color: _isFocused ? Colors.red : Colors.black,
          ), // Set label color to red when focused
          suffixIcon: widget.suffixIcon,
          prefixIcon: widget.prefixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(color: Colors.red), // Set border color to red
          ),
          focusedBorder: OutlineInputBorder(
            // Set focused border color to red
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
