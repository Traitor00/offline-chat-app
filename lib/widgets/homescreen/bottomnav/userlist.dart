import 'dart:io';

import 'package:chatapp/view/chatpage.dart';
import 'package:chatapp/viewmodel/homepage/navbarviewmodel/userviewmodel.dart';
import 'package:chatapp/viewmodel/signinviewmodel.dart';
import 'package:chatapp/widgets/customappbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    UserViewModel provider = Provider.of<UserViewModel>(context, listen: false);
    SignInViewModel provideruser =
        Provider.of<SignInViewModel>(context, listen: false);

    return Scaffold(
        appBar: CustomAppBar(
          content: "All Contacts",
        ),
        body: FutureBuilder(
          future: provider.getUser(provideruser.userid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              final data = snapshot.data;
              return ListView.builder(
                itemCount: data!.length,
                itemBuilder: (context, index) {
                  final user = data[index];
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              ChatPageScreen(provideruser.userid, user.id)));
                    },
                    title: Text("${user.name}"),
                    leading: CircleAvatar(
                      backgroundImage: FileImage(
                        File(user.imageUrl!),
                      ),
                      radius: 20,
                    ),
                  );
                },
              );
            }
            return Center(child: Text("User list empty"));
          },
        ));
  }
}
