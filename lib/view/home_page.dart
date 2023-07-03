import 'package:chatapp/viewmodel/chat/call_view_model.dart';
import 'package:chatapp/viewmodel/homepage/navbarviewmodel/navbar_view_model.dart';
import 'package:chatapp/viewmodel/homepage/home_page_view_model.dart';
import 'package:chatapp/viewmodel/signin_view_model.dart';
import 'package:chatapp/widgets/homescreen/bottomnav/messages.dart';
import 'package:chatapp/widgets/homescreen/bottomnav/settinglist.dart';
import 'package:chatapp/widgets/homescreen/bottomnav/userlist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final int? userid;
  HomePage({this.userid, super.key});

  /// List of Navbars pages
  final currentTab = [
    UserList(),
    MessagesList(),
    SettingList(),
  ];

  @override
  Widget build(BuildContext context) {
    BottomNavigationBarProvider provider =
        Provider.of<BottomNavigationBarProvider>(context);
    HomePageViewModel messageProvider =
        Provider.of<HomePageViewModel>(context, listen: false);
    messageProvider.userId = userid ?? 0;

    CallViewModel callProvider =
        Provider.of<CallViewModel>(context, listen: false);
    SignInViewModel provideruser =
        Provider.of<SignInViewModel>(context, listen: false);
    callProvider.senderid = provideruser.userid;
    callProvider.getSenderNumber();

    return Scaffold(
      body: currentTab[provider.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        enableFeedback: true,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: provider.currentIndex,
        onTap: (index) {
          provider.currentIndex = index;
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "User"),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Message"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Setting")
        ],
      ),
    );
  }
}
