import 'dart:io';

import 'package:chatapp/view/chatpage.dart';
import 'package:chatapp/viewmodel/homepage/homepageviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class MessageinsideTabbar extends StatelessWidget {
  const MessageinsideTabbar({super.key});

  @override
  Widget build(BuildContext context) {
    HomePageViewModel provider =
        Provider.of<HomePageViewModel>(context, listen: false);

    return FutureBuilder(
      future: provider.messageFetch(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text("Unable to show Messages");
        } else if (snapshot.hasData) {
          final data = snapshot.data;
          if (data!.isEmpty) {
            return Center(child: Text("No Messages Found"));
          } else {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final messages = data[index];
                final DateTime time = DateTime.parse(messages.updatedat!);

                return ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ChatPageScreen(provider.userId,
                            messages.recieverid, messages.name)));
                  },
                  title: Text(messages.name!),
                  leading: CircleAvatar(
                    backgroundImage: messages.imageUrl == null
                        ? NetworkImage('https://i.stack.imgur.com/l60Hf.png')
                        : FileImage(
                            File(messages.imageUrl!),
                          ) as ImageProvider,
                    /*FileImage(
                      File(messages.imageUrl!),
                    ),*/
                    radius: 20,
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.56,
                        child: Text(
                          messages.message!,
                          softWrap: false,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        "${timeago.format(time, locale: 'en_short')} ago",
                      ),
                    ],
                  ),
                );
              },
            );
          }
        }
        return Center(child: Text("No Messages To Show"));
      },
    );
  }
}
