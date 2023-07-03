import 'package:chatapp/viewmodel/chat/callviewmodel.dart';
import 'package:chatapp/viewmodel/chat/insertchatviewmodel.dart';
import 'package:chatapp/widgets/message/buildmessagebuble.dart';
import 'package:chatapp/widgets/message/chatpgbottomcontainer.dart';
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

    ///sending senderid and receiverid to chatprovider and setting
    provider.senderId = widget.senderIid!;
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
                      final bool isMiddleMessage = data1.length < (index + 2)
                          ? false
                          : index == 0
                              ? false
                              : data1[index - 1].senderid ==
                                      data1[index + 1].senderid &&
                                  continuousMessage;

                      /// message bubble
                      return BuildMessageBuble(
                        continuousMessage: continuousMessage,
                        isMe: isMe,
                        message: message,
                        isMiddleMessage: isMiddleMessage,
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
