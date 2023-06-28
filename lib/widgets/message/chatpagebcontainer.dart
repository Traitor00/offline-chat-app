import 'package:chatapp/widgets/customiconbutton.dart';
import 'package:provider/provider.dart';
import 'package:chatapp/viewmodel/chat/insertchatviewmodel.dart';
import 'package:flutter/material.dart';

class ChatPgBtmContainer extends StatelessWidget {
  final VoidCallback? onPressed;
  final int? receiverIid;
  final int? senderIid;
  const ChatPgBtmContainer(
      {this.onPressed, this.receiverIid, this.senderIid, super.key});

  @override
  Widget build(BuildContext context) {
    ChatProvider provider = Provider.of<ChatProvider>(context, listen: false);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            //offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                provider.getimage();
                provider.clearSelectedImage();
              },
              icon: Icon(Icons.add_a_photo)),
          Expanded(
            child: TextField(
              controller: provider.messageController,
              decoration: InputDecoration.collapsed(
                hintText: 'Type your message...',
              ),
            ),
          ),
          IconButton(
              enableFeedback: true,
              onPressed: () {
                provider.senderId = receiverIid!;
                provider.receiverId = senderIid!;
              },
              icon: Icon(
                Icons.switch_right_sharp,
              )),
          CustomIconButton(icon: Icon(Icons.send), onPressed: onPressed),
          /*IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              provider.doChat();
              setState(() {
                provider.messageFetch();
              });
            },
          ),*/
        ],
      ),
    );
  }
}
