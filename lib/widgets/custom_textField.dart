import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController editcontroller;
  final String labelText;
  final bool obscureText;
  const CustomTextField(
      {required this.editcontroller,
      required this.labelText,
      required this.obscureText,
      super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: editcontroller,
      decoration: InputDecoration(labelText: labelText),
      obscureText: obscureText,
    );
  }
}
