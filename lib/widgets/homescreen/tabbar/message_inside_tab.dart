import 'dart:io';
import 'package:chatapp/model/combined.dart';
import 'package:chatapp/view/chat_page.dart';
import 'package:chatapp/viewmodel/homepage/home_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class MessageinsideTabbar extends StatelessWidget {
  const MessageinsideTabbar({super.key});

  @override
  Widget build(BuildContext context) {
    HomePageViewModel provider = context.read<HomePageViewModel>();

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
          final data = snapshot.data ?? [];
          if (data.isEmpty) {
            return Center(child: Text("No Messages Found"));
          } else {
            return _buildListView(data, provider);
          }
        }
        return Center(child: Text("No Messages To Show"));
      },
    );
  }

  ListView _buildListView(List<Combined> data, HomePageViewModel provider) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final messages = data[index];
        final DateTime time = DateTime.parse(messages.updatedat ?? '');

        return _buildListTile(context, provider, messages, time);
      },
    );
  }

  ListTile _buildListTile(BuildContext context, HomePageViewModel provider,
      Combined messages, DateTime time) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ChatPageScreen(provider.userId,
                messages.recieverid ?? 0, messages.name ?? "")));
      },
      title: Text(messages.name!),
      leading: _buildCircleAvtar(messages),
      subtitle: _buildSubTitle(context, messages, time),
    );
  }

  CircleAvatar _buildCircleAvtar(Combined messages) {
    return CircleAvatar(
      backgroundImage: messages.imageUrl == null
          ? AssetImage('assets/default.png')
          : FileImage(
              File(messages.imageUrl!),
            ) as ImageProvider,
      radius: 20,
    );
  }

  Row _buildSubTitle(BuildContext context, Combined messages, DateTime time) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.56,
          child: Text(
            messages.message ?? '',
            softWrap: false,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          "${timeago.format(time, locale: 'en_short')} ago",
        ),
      ],
    );
  }
}
