import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String? content;

  double? size;

  CustomText({this.content, this.size, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "${content}",
      style: TextStyle(
          color: Colors.grey[700], fontSize: size, fontWeight: FontWeight.w300),
    );
  }
}
