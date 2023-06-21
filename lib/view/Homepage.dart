import 'package:chatapp/viewmodel/homepage/navbarviewmodel/navbarviewmodel.dart';
import 'package:chatapp/viewmodel/homepage/homepageviewmodel.dart';
import 'package:chatapp/widgets/homescreen/bottomnav/messages.dart';
import 'package:chatapp/widgets/homescreen/bottomnav/settinglist.dart';
import 'package:chatapp/widgets/homescreen/bottomnav/userlist.dart';
import 'package:chatapp/widgets/homescreen/tabbar/tabbarindicator.dart';
import 'package:chatapp/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final int? userid;
  const HomePage({this.userid, super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// List of Navbars pages
  var currentTab = [
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
    messageProvider.userId = widget.userid!;

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
        items: [
          BottomNavigationBarItem(icon: new Icon(Icons.person), label: "User"),
          BottomNavigationBarItem(
              icon: new Icon(Icons.message), label: "Message"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Setting")
        ],
      ),
    );
  }
}
