import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Ctextform extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
