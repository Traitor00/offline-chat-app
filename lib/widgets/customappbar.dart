import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  String? content;
  bool? ismessage;
  CustomAppBar({this.content, this.ismessage, super.key});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shadowColor: Colors.white70,
      backgroundColor: Colors.white54,
      automaticallyImplyLeading: false,
      title: Text(
        "$content",
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        Icon(
          Icons.search,
          color: Colors.black,
        ),
        SizedBox(
          width: 10,
        ),
        Icon(
          Icons.person_add,
          color: Colors.black,
        ),
        SizedBox(
          width: 10,
        )
      ],
    );
  }
}
