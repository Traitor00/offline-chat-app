import 'dart:io';
import 'package:chatapp/model/combined.dart';
import 'package:chatapp/viewmodel/chat/insertchatviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatPageScreen extends StatefulWidget {
  int? senderIid;
  int? receiverIid;
  ChatPageScreen(this.senderIid, this.receiverIid);

  @override
  State<ChatPageScreen> createState() => _ChatPageScreenState();
}

class _ChatPageScreenState extends State<ChatPageScreen> {
  @override
  Widget build(BuildContext context) {
    ChatProvider provider = Provider.of<ChatProvider>(context, listen: false);
    provider.senderId = widget.senderIid!;
    provider.receiverId = widget.receiverIid!;

    return Scaffold(
        appBar: AppBar(
          title: Text("Chat"), //otherUser.name!
        ),
        body: FutureBuilder(
          future: provider.messageFetch(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data1 = snapshot.data;
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      itemCount: data1!.length,
                      itemBuilder: (context, index) {
                        final message = data1[index];
                        final isMe = message.senderid == widget.senderIid;

                        return _buildMessageBubble(message, isMe);
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 2),
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
                              provider.senderId = widget.receiverIid!;
                              provider.receiverId = widget.senderIid!;
                            },
                            icon: Icon(
                              Icons.switch_right_sharp,
                            )),
                        IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () {
                            provider.doChat(context);
                            setState(() {
                              provider.messageFetch();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            return Text("Sorry");
          },
        ));
  }

  Widget _buildMessageBubble(Combined message, bool isMe) {
    final DateTime time = DateTime.parse(message.updatedat!);

    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isMe)
          Container(
            margin: EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              backgroundImage: FileImage(
                File(message.imageUrl!),
              ),
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
                : Container(
                    padding: EdgeInsets.all(8.0),
                    margin:
                        EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                    decoration: BoxDecoration(
                      color: isMe ? Colors.blue[100] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      crossAxisAlignment: isMe
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Text(
                          message.message!,
                          maxLines: 3,
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          "${timeago.format(time, locale: 'en_short')} ago",
                          style: TextStyle(
                              fontSize: 12.0, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
          ],
        )
      ],
    );
  }
}
