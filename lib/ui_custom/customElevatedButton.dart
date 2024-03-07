import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Widget child;
  final Function(String)? onChanged;

  CustomElevatedButton({
    required this.label,
    required this.onPressed,
    required this.child,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
                        width: 250,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
                              onPrimary: Colors.white,
                              primary:Colors.red,
                            ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: child,
        ),
      ),
    );
  }
}
 