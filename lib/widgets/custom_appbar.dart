import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? content;
  final bool ismessage;
  const CustomAppBar({this.content, required this.ismessage, super.key});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shadowColor: Colors.white70,
      backgroundColor: Colors.white54,
      automaticallyImplyLeading: ismessage ? true : false,
      leading: ismessage ? BackButton(color: Colors.black) : null,
      title: Text(
        "$content",
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        ismessage
            ? Row(
                children: const [
                  Icon(
                    Icons.call,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 20,
                  )
                ],
              )
            : Row(
                children: const [
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
              )
      ],
    );
  }
}
