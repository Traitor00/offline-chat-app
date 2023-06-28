import 'dart:io';

import 'package:chatapp/model/combined.dart';
import 'package:chatapp/widgets/message/messagebblcontainer.dart';
import 'package:chatapp/widgets/message/urlpreviewmsg.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

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
    final DateTime time = DateTime.parse(message.updatedat!);

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
              /*FileImage(
                File(message.imageUrl!),
              ),*/
              radius: 20,
            ),
          ),
        Column(
          children: [
            message.img != null
                ? Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Image.file(
                          File(message.img!),
                          fit: BoxFit.cover,
                          height: 200,
                          width: 150,
                        ),
                        Text(
                          "${timeago.format(time, locale: 'en_short')} ago",
                          style: TextStyle(
                              fontSize: 12.0, color: Colors.grey[600]),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ))
                : message.message!.startsWith("https")
                    ? UrlPreviewMsg(
                        isMe: isMe,
                        url: message.message,
                        continuousMessage: continuousMessage,
                        message: message,
                      )
                    : GestureDetector(
                        onLongPress: () {},
                        child: CustomMessageContainer(
                          isMe: isMe,
                          continuousMessage: continuousMessage,
                          message: message,
                        ),
                      )
          ],
        )
      ],
    );
  }
}
