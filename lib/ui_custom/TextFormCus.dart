import 'package:flutter/material.dart';

class Ctextform extends StatelessWidget {
  bool obscureText;
  String? labelText;
  String? Function(String?)? validator;
  Widget? suffixIcon;
  Widget? prefixIcon;
  Function(String)? onChanged;

  Ctextform(
      {super.key,
      this.validator,
      this.suffixIcon,
      this.prefixIcon,
      this.labelText,
      this.obscureText = false,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      onChanged: onChanged,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}
