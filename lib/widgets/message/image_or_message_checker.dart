import 'package:chatapp/model/combined.dart';
import 'package:chatapp/widgets/message/custom_message_bbl_container.dart';
import 'package:chatapp/widgets/message/image_container_msg.dart';
import 'package:chatapp/widgets/message/url_preview_msg.dart';
import 'package:flutter/material.dart';

class ImageOrMessageChecker extends StatelessWidget {
  const ImageOrMessageChecker({
    super.key,
    required this.message,
    required this.isMe,
    required this.continuousMessage,
  });

  final Combined message;
  final bool isMe;
  final bool continuousMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
// Checks whether we gets image from database if image is not null then displays Image container
        message.img != null
            ? ImageContainerMessage(message: message)
            // Checks Whether message starts with https if yes than shows url preview
            : message.message?.startsWith("https") ?? false
                ? UrlPreviewMsg(
                    isMe: isMe,
                    url: message.message ?? '',
                    continuousMessage: continuousMessage,
                    message: message,
                  )
                // At last it displays Message Container
                : CustomMessageContainer(
                    isMe: isMe,
                    continuousMessage: continuousMessage,
                    message: message,
                  )
      ],
    );
  }
}
