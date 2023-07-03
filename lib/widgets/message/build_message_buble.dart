import 'dart:io';
import 'package:chatapp/model/combined.dart';
import 'package:chatapp/widgets/message/custom_message_bbl_container.dart';
import 'package:chatapp/widgets/message/image_container_msg.dart';
import 'package:chatapp/widgets/message/url_preview_msg.dart';
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
        if (!isMe)
          Container(
            margin: EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              backgroundImage: message.imageUrl == null
                  ? AssetImage('assets/default.png')
                  : FileImage(
                      File(message.imageUrl ?? ''),
                    ) as ImageProvider,
              radius: 20,
            ),
          ),
        Column(
          children: [
            message.img != null
                ? ImageContainerMessage(message: message)
                : message.message?.startsWith("https") ?? false
                    ? UrlPreviewMsg(
                        isMe: isMe,
                        url: message.message ?? '',
                        continuousMessage: continuousMessage,
                        message: message,
                      )
                    : CustomMessageContainer(
                        isMe: isMe,
                        continuousMessage: continuousMessage,
                        message: message,
                      )
          ],
        )
      ],
    );
  }
}
