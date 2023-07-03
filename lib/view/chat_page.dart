import 'package:chatapp/viewmodel/chat/call_view_model.dart';
import 'package:chatapp/viewmodel/chat/chat_view_model.dart';
import 'package:chatapp/widgets/message/build_message_buble.dart';
import 'package:chatapp/widgets/message/chat_pg_bottom_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPageScreen extends StatelessWidget {
  final int senderIid;
  final int receiverIid;
  final String name;
  const ChatPageScreen(this.senderIid, this.receiverIid, this.name,
      {super.key});

  @override
  Widget build(BuildContext context) {
    ChatProvider provider = Provider.of<ChatProvider>(context, listen: true);
    CallViewModel callProvider =
        Provider.of<CallViewModel>(context, listen: false);

    ///sending senderid and receiverid to  call viewmodel
    callProvider.receiverid = receiverIid;
    callProvider.senderid = senderIid;

    ///calling callviewmodel functions
    callProvider.getReceiverNumber();
    callProvider.getSenderNumber();

    ///sending senderid and receiverid to chatviewmodel
    provider.senderId = senderIid;
    provider.receiverId = receiverIid;

    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.white70,
        backgroundColor: Colors.white54,
        title: Text(name, style: TextStyle(color: Colors.black)),
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
            final data1 = snapshot.data ?? [];
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: data1.length,
                    itemBuilder: (context, index) {
                      final message = data1[index];

                      ///bool to check whether sender i.e I am sending or person on other end
                      final isMe = message.senderid == senderIid;
                      callProvider.receiverno = message.phoneno ?? '';

                      ///We will creating a bool which will check whether the
                      ///current user and next user are same and if their
                      ///time difference is less than 1 min
                      ///  convert String date  time to Datetime

                      final bool continuousMessage = data1.length < (index + 2)
                          ? false
                          : message.senderid == data1[index + 1].senderid &&
                              DateTime.parse(message.updatedat ?? '')
                                      .difference(DateTime.parse(
                                          data1[index + 1].updatedat ?? ''))
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
                  receiverIid: receiverIid,
                  senderIid: senderIid,
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
