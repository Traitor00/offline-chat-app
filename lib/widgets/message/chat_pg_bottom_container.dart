import 'package:chatapp/widgets/custom_icon_button.dart';
import 'package:provider/provider.dart';
import 'package:chatapp/viewmodel/chat/chat_view_model.dart';
import 'package:flutter/material.dart';

class ChatPageBottomContainer extends StatelessWidget {
  final int receiverid;
  final int senderid;
  const ChatPageBottomContainer(
      {required this.receiverid, required this.senderid, super.key});

  @override
  Widget build(BuildContext context) {
    ChatProvider chatProviderReader = context.read<ChatProvider>();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          _imageSelectorIcon(chatProviderReader),
          _messageTypingTextField(chatProviderReader),
          _usersSwitchingIcon(chatProviderReader),
          _messageSendingIcon(chatProviderReader),
        ],
      ),
    );
  }

  CustomIconButton _messageSendingIcon(ChatProvider chatProviderReader) {
    return CustomIconButton(
        icon: Icon(Icons.send),
        onPressed: () {
          chatProviderReader.messageSend();
        });
  }

  IconButton _usersSwitchingIcon(ChatProvider chatProviderReader) {
    return IconButton(
        enableFeedback: true,
        onPressed: () {
          chatProviderReader.toggleUsers(senderid, receiverid);
        },
        icon: Icon(
          Icons.switch_right_sharp,
        ));
  }

  Expanded _messageTypingTextField(ChatProvider chatProviderReader) {
    return Expanded(
      child: TextField(
        controller: chatProviderReader.messageController,
        decoration: InputDecoration.collapsed(
          hintText: 'Type your message...',
        ),
      ),
    );
  }

  IconButton _imageSelectorIcon(ChatProvider chatProviderReader) {
    return IconButton(
      onPressed: () {
        chatProviderReader.getimage();
      },
      icon: Icon(Icons.add_a_photo),
    );
  }
}
