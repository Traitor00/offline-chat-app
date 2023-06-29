import 'package:chatapp/viewmodel/homepage/navbarviewmodel/navbarviewmodel.dart';
import 'package:chatapp/viewmodel/homepage/homepageviewmodel.dart';
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
    messageProvider.userId = userid!;

    return Scaffold(
      body: currentTab[provider.currentIndex],
      bottomNavigationBar: HomePagNavigitionBar(provider: provider),
    );
  }
}

class HomePagNavigitionBar extends StatelessWidget {
  const HomePagNavigitionBar({
    super.key,
    required this.provider,
  });

  final BottomNavigationBarProvider provider;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
    );
  }
}
