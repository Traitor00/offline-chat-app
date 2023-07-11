import 'dart:io';
import 'package:chatapp/constants/constant.dart';
import 'package:chatapp/model/combined.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/material.dart';

class ImageContainerMessage extends StatelessWidget {
  final Combined message;
  const ImageContainerMessage({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime time = DateTime.parse(message.updatedat ?? '');

    return Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            _imageRectangularContainer(),
            Text(
              "${timeago.format(time, locale: 'en_short')} ago",
              style: leadingTime,
            ),
            SizedBox(
              height: 10,
            )
          ],
        ));
  }

  ClipRRect _imageRectangularContainer() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.file(
        File(message.img ?? ''),
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            'assets/Image_not_available.png',
            fit: BoxFit.contain,
            height: 200,
            width: 150,
          );
        },
        fit: BoxFit.cover,
        height: 200,
        width: 150,
      ),
    );
  }
}
