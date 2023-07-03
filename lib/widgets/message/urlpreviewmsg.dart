import 'package:chatapp/constants/constant.dart';
import 'package:chatapp/model/combined.dart';
import 'package:chatapp/widgets/message/custommessagebblcontainer.dart';
import 'package:flutter/material.dart';
import 'package:any_link_preview/any_link_preview.dart';

class UrlPreviewMsg extends StatelessWidget {
  final String? url;
  final bool isMe;
  final bool? continuousMessage;
  final Combined? message;
  const UrlPreviewMsg(
      {this.url,
      required this.isMe,
      this.continuousMessage,
      this.message,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          minWidth: 50, maxWidth: 200, minHeight: 20, maxHeight: 80),
      margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
      child: AnyLinkPreview(
        link: url!,
        displayDirection: UIDirection.uiDirectionHorizontal,
        bodyStyle: TextStyle(color: Colors.black87),
        cache: Duration(hours: 2),
        backgroundColor: isMe ? Colors.blue[100] : Colors.grey[300],
        errorWidget: CustomMessageContainer(
          continuousMessage: continuousMessage,
          isMe: isMe,
          message: message,
        ),
        errorImage: errorImage,
      ),
    );
  }
}
