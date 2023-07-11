import 'package:chatapp/model/combined.dart';
import 'package:chatapp/viewmodel/chat/call_view_model.dart';
import 'package:chatapp/viewmodel/chat/chat_view_model.dart';
import 'package:chatapp/widgets/message/build_message_buble.dart';
import 'package:chatapp/widgets/message/chat_pg_bottom_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPageScreen extends StatefulWidget {
  final int senderid;
  final int receiverid;
  final String name;
  const ChatPageScreen(this.senderid, this.receiverid, this.name, {super.key});

  @override
  State<ChatPageScreen> createState() => _ChatPageScreenState();
}

class _ChatPageScreenState extends State<ChatPageScreen> {
  @override
  void initState() {
    ChatProvider chatProviderReader = context.read<ChatProvider>();
    CallViewModel callProviderReader = context.read<CallViewModel>();

    // Sending senderid and receiverid to  call viewmodel
    callProviderReader.receiverid = widget.receiverid;
    callProviderReader.senderid = widget.senderid;

    // Calling callviewmodel functions
    callProviderReader.getReceiverNumber();
    callProviderReader.getSenderNumber();

    // Sending senderid and receiverid to chatviewmodel
    chatProviderReader.senderId = widget.senderid;
    chatProviderReader.receiverId = widget.receiverid;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Assigned the setter here because we needed to reassign same value once the widget rebuild
    //after toggling user id
    context.read<ChatProvider>().senderId = widget.senderid;
    context.read<ChatProvider>().receiverId = widget.receiverid;
    return Scaffold(
      appBar: _buildAppBar(context.read<CallViewModel>()),

      // Create widgets based on the latest snapshot of interaction with a Future
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FutureBuilder(
            // Listening to changes of ChatProvider class
            future: context.watch<ChatProvider>().messageFetch(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(child: Text("${snapshot.error}"));
                } else if (snapshot.data == null) {
                  return Text("No Data recieved");
                } else if (snapshot.hasData) {
                  final snapshotData = snapshot.data!;
                  return _buildSuccessBody(snapshotData);
                }
              }
              // Waiting state
              return Center(child: CircularProgressIndicator());
            },
          ),
          ChatPageBottomContainer(
            receiverid: widget.receiverid,
            senderid: widget.senderid,
          )
        ],
      ),
    );
  }

  Expanded _buildSuccessBody(List<Combined> snapshotData) {
    return Expanded(
      // Chat container above textfield
      child: _buildMessageList(snapshotData),
    );
  }

  ListView _buildMessageList(List<Combined> snapshotData) {
    return ListView.builder(
      reverse: true,
      itemCount: snapshotData.length,
      itemBuilder: (context, index) {
        final message = snapshotData[index];
        // Bool to check whether sender i.e I am sending or person on other end
        final isMe = message.senderid == widget.senderid;
        final bool continuousMessage =
            isContinuesMessage(snapshotData, index, message);
        return BuildMessageBuble(
          continuousMessage: continuousMessage,
          isMe: isMe,
          message: message,
        );
      },
    );
  }

  /// We will creating a boolean which will check whether the
  /// Current messages index user and next user are same and if their
  /// time difference is less than 1 min
  ///  convert String date  time to Datetime
  bool isContinuesMessage(
      List<Combined> snapshotData, int index, Combined message) {
    return snapshotData.length < (index + 2)
        ? false
        : message.senderid == snapshotData[index + 1].senderid &&
            DateTime.parse(message.updatedat ?? '')
                    .difference(
                        DateTime.parse(snapshotData[index + 1].updatedat ?? ''))
                    .inMinutes <=
                1;
  }

  /// AppBar with call facility and shows name of a user
  AppBar _buildAppBar(CallViewModel callProviderReader) {
    return AppBar(
      shadowColor: Colors.white70,
      backgroundColor: Colors.white54,
      title: Text(widget.name, style: TextStyle(color: Colors.black)),
      leading: BackButton(color: Colors.black),
      actions: [
        GestureDetector(
          onTap: () {
            callProviderReader.callHistoryAdd();
            callProviderReader.makePhoneCall();
          },
          child: Icon(
            Icons.call,
            color: Colors.black,
          ),
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }
}
