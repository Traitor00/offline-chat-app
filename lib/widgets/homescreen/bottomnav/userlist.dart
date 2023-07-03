import 'dart:io';

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
    UserViewModel provider = Provider.of<UserViewModel>(context, listen: false);

    ///to get info of signed in user
    SignInViewModel provideruser =
        Provider.of<SignInViewModel>(context, listen: false);

    return Scaffold(
      appBar: CustomAppBar(
        content: "All Contacts",
        ismessage: false,
      ),
      body: FutureBuilder(
        future: provider.getAllUsers(provideruser.userid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.data == null) {
            return Text("No Users Found");
          } else if (snapshot.hasData) {
            final data = snapshot.data;
            return ListView.builder(
              itemCount: data!.length,
              itemBuilder: (context, index) {
                final user = data[index];
                return ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ChatPageScreen(
                            provideruser.userid,
                            user.id ?? 0,
                            user.name ?? "")));
                  },
                  title: Text(user.name ?? ''),
                  leading: CircleAvatar(
                    //child: user.imageUrl==null?Text(user.name),
                    backgroundImage: user.imageUrl == null
                        ? AssetImage('assets/default.png')
                        : FileImage(
                            File(user.imageUrl!),
                          ) as ImageProvider,
                    radius: 20,
                  ),
                );
              },
            );
          }
          return Center(child: Text("User list empty"));
        },
      ),
    );
  }
}
