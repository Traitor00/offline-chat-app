import 'package:chatapp/viewmodel/chat/callviewmodel.dart';
import 'package:chatapp/viewmodel/chat/insertchatviewmodel.dart';
import 'package:chatapp/widgets/message/buildmessagebuble.dart';
import 'package:chatapp/widgets/message/chatpagebcontainer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPageScreen extends StatefulWidget {
  final int? senderIid;
  final int? receiverIid;
  final String? name;
  const ChatPageScreen(this.senderIid, this.receiverIid, this.name,
      {super.key});

  @override
  State<ChatPageScreen> createState() => _ChatPageScreenState();
}

class _ChatPageScreenState extends State<ChatPageScreen> {
  @override
  void initState() {
    CallViewModel callProvider =
        Provider.of<CallViewModel>(context, listen: false);
    callProvider.receiverid = widget.receiverIid!;
    callProvider.senderid = widget.senderIid!;
    callProvider.getReceiverNumber();
    callProvider.getSenderNumber();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ChatProvider provider = Provider.of<ChatProvider>(context, listen: false);
    CallViewModel callProvider =
        Provider.of<CallViewModel>(context, listen: false);
    provider.senderId = widget.senderIid!;

    ///sending senderid and receiverid to chatprovider and setting
    provider.receiverId = widget.receiverIid!;

    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.white70,
        backgroundColor: Colors.white54,
        title: Text(widget.name!, style: TextStyle(color: Colors.black)),
        leading: BackButton(color: Colors.black),
        actions: [
          GestureDetector(
            onTap: () {
              //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Call()));
              callProvider.callHistoryAdd();
              callProvider.makePhoneCall();
            },
            child: Icon(
              Icons.call,
              color: Colors.black,
            ),
          ),
          SizedBox(
            width: 20,
          )
        ], //otherUser.name!
      ),

      /*CustomAppBar(
          content: "Chat",
          ismessage: true,
        ),*/

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

                      ///bool to check whether sender i.e I am sending or person on other end
                      final isMe = message.senderid == widget.senderIid;
                      callProvider.receiverno = message.phoneno!;

                      ///We will creating a bool which will check whether the
                      ///current user and next user are same and if their
                      ///time difference is less than 1 min
                      ///  convert String date  time to Datetime

                      final bool continuousMessage = data1.length < (index + 2)
                          ? false
                          : message.senderid == data1[index + 1].senderid &&
                              DateTime.parse(message.updatedat!)
                                      .difference(DateTime.parse(
                                          data1[index + 1].updatedat!))
                                      .inMinutes <=
                                  1;

                      /// message bubble
                      return BuildMessageBuble(
                        continuousMessage: continuousMessage,
                        isMe: isMe,
                        message: message,
                      );
                    },
                  ),
                ),

                ///widget class to show icons and textfields
                ChatPgBtmContainer(
                  receiverIid: widget.receiverIid,
                  senderIid: widget.senderIid,
                  onPressed: () {
                    provider.doChat();
                    setState(() {
                      provider.messageFetch();
                    });
                  },
                )
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}


// Container(
                //   padding: EdgeInsets.symmetric(horizontal: 8.0),
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.grey.withOpacity(0.5),
                //         spreadRadius: 1,
                //         blurRadius: 5,
                //         //offset: Offset(0, 2),
                //       ),
                //     ],
                //   ),
                //   child: Row(
                //     children: [
                //       IconButton(
                //           onPressed: () {
                //             provider.getimage();
                //             provider.clearSelectedImage();
                //           },
                //           icon: Icon(Icons.add_a_photo)),
                //       Expanded(
                //         child: TextField(
                //           controller: provider.messageController,
                //           decoration: InputDecoration.collapsed(
                //             hintText: 'Type your message...',
                //           ),
                //         ),
                //       ),
                //       IconButton(
                //           enableFeedback: true,
                //           onPressed: () {
                //             provider.senderId = widget.receiverIid!;
                //             provider.receiverId = widget.senderIid!;
                //           },
                //           icon: Icon(
                //             Icons.switch_right_sharp,
                //           )),
                //       IconButton(
                //         icon: Icon(Icons.send),
                //         onPressed: () {
                //           provider.doChat();
                //           setState(() {
                //             provider.messageFetch();
                //           });
                //         },
                //       ),
                //     ],
                //   ),
                // ),
  /*Widget _buildMessageBubble(
      Combined message, bool isMe, bool continuousMessage) {
    //print("_buildMessageBubble called");
    final DateTime time = DateTime.parse(message.updatedat!);
    final DateTime time1 = DateTime.parse(message.updatedat!);
    // String formattedTime = DateFormat.jm().format(time);
    // String formattedTime1 = DateFormat.jm().format(time1);

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
                    : CustomMessageContainer(
                        continuousMessage: continuousMessage,
                        isMe: isMe,
                        message: message,
                      )
          ],
        )
      ],
    );
  }
}
*/