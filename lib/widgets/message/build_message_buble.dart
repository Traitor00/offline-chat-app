import 'dart:io';
import 'package:chatapp/model/combined.dart';
import 'package:chatapp/widgets/message/image_or_message_checker.dart';
import 'package:flutter/material.dart';

class BuildMessageBuble extends StatelessWidget {
  final bool isMe;
  final bool continuousMessage;
  final Combined message;
  const BuildMessageBuble(
      {required this.continuousMessage,
      required this.isMe,
      required this.message,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        // Checks if sender is not loggedin User than shows circle avtar before message
        if (!isMe) _circleAvatarContainer(),
        // Shows Message or Image on the basis of received data
        ImageOrMessageChecker(
            message: message, isMe: isMe, continuousMessage: continuousMessage)
      ],
    );
  }

  /// Container which contains Circle Avtar widget
  Container _circleAvatarContainer() {
    return Container(
      margin: EdgeInsets.only(right: 8.0),
      child: _circleAvtar(),
    );
  }

  CircleAvatar _circleAvtar() {
    return CircleAvatar(
      backgroundImage: message.imageUrl == null
          ? AssetImage('assets/default.png')
          : FileImage(
              File(message.imageUrl ?? ''),
            ) as ImageProvider,
      radius: 20,
    );
  }
}
