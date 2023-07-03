import 'dart:io';
import 'package:chatapp/model/combined.dart';
import 'package:chatapp/widgets/message/custommessagebblcontainer.dart';
import 'package:chatapp/widgets/message/imagecontainermsg.dart';
import 'package:chatapp/widgets/message/urlpreviewmsg.dart';
import 'package:flutter/material.dart';

class BuildMessageBuble extends StatelessWidget {
  final bool isMe;
  final bool continuousMessage;
  final Combined message;
  final bool isMiddleMessage;
  const BuildMessageBuble(
      {required this.continuousMessage,
      required this.isMe,
      required this.message,
      required this.isMiddleMessage,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isMe)
          Container(
            margin: EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              backgroundImage: message.imageUrl == null
                  ? NetworkImage('https://i.stack.imgur.com/l60Hf.png')
                  : FileImage(
                      File(message.imageUrl!),
                    ) as ImageProvider,
              radius: 20,
            ),
          ),
        Column(
          children: [
            message.img != null
                ? ImageContainerMessage(message: message)
                : message.message!.startsWith("https")
                    ? UrlPreviewMsg(
                        isMe: isMe,
                        url: message.message,
                        continuousMessage: continuousMessage,
                        message: message,
                      )
                    : CustomMessageContainer(
                        isMe: isMe,
                        continuousMessage: continuousMessage,
                        message: message,
                        isMiddleMessage: isMiddleMessage,
                      )
          ],
        )
      ],
    );
  }
}
