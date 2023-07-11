import 'dart:io';

import 'package:chatapp/model/user.dart';
import 'package:chatapp/view/chat_page.dart';
import 'package:chatapp/viewmodel/homepage/navbarviewmodel/user_view_model.dart';
import 'package:chatapp/viewmodel/signin_view_model.dart';
import 'package:chatapp/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    UserViewModel userProviderReader = context.read<UserViewModel>();

    ///to get info of signed in user
    SignInViewModel loggedinUserIdProvider = context.read<SignInViewModel>();

    return Scaffold(
      appBar: CustomAppBar(
        content: "All Contacts",
        ismessage: false,
      ),
      body: FutureBuilder(
        future: userProviderReader.getAllUsers(loggedinUserIdProvider.userid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.data == null) {
            return Text("No Users Found");
          } else if (snapshot.hasData) {
            final data = snapshot.data;
            return _buildListViewBuilder(data, loggedinUserIdProvider);
          }
          return Center(child: Text("User list empty"));
        },
      ),
    );
  }

  ListView _buildListViewBuilder(
      List<User>? data, SignInViewModel loggedinUserIdProvider) {
    return ListView.builder(
      itemCount: data!.length,
      itemBuilder: (context, index) {
        final user = data[index];
        return ListTile(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ChatPageScreen(
                    loggedinUserIdProvider.userid,
                    user.id ?? 0,
                    user.name ?? "")));
          },
          title: Text(user.name ?? ''),
          leading: _buildCircleAvtar(user),
        );
      },
    );
  }

  CircleAvatar _buildCircleAvtar(User user) {
    return CircleAvatar(
      backgroundImage: user.imageUrl == null
          ? AssetImage('assets/default.png')
          : FileImage(
              File(user.imageUrl ?? ""),
            ) as ImageProvider,
      radius: 20,
    );
  }
}
