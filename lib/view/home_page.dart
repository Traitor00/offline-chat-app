import 'package:chatapp/viewmodel/chat/call_view_model.dart';
import 'package:chatapp/viewmodel/homepage/navbarviewmodel/navbar_view_model.dart';
import 'package:chatapp/viewmodel/homepage/home_page_view_model.dart';
import 'package:chatapp/widgets/homescreen/bottomnav/messages.dart';
import 'package:chatapp/widgets/homescreen/bottomnav/settinglist.dart';
import 'package:chatapp/widgets/homescreen/bottomnav/userlist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final int userid;
  const HomePage({required this.userid, super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    HomePageViewModel messageProvider = context.read<HomePageViewModel>();
    messageProvider.userId = widget.userid;

    // Setting value to senderid  of callprovider to fetch call history by using
    CallViewModel callProvider = context.read<CallViewModel>();
    callProvider.senderid = widget.userid;
    callProvider.getSenderNumber();
    super.initState();
  }

  // List of Navbars pages
  final currentTab = [
    UserList(),
    MessagesList(),
    SettingList(),
  ];

  @override
  Widget build(BuildContext context) {
    BottomNavigationBarProvider bottomnavProvider =
        context.read<BottomNavigationBarProvider>();
    return Scaffold(
      body: currentTab[bottomnavProvider.currentIndex],
      bottomNavigationBar: _bottomNavigationBar(context, bottomnavProvider),
    );
  }

  BottomNavigationBar _bottomNavigationBar(
      BuildContext context, BottomNavigationBarProvider bottomnavProvider) {
    return BottomNavigationBar(
      enableFeedback: true,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: context.watch<BottomNavigationBarProvider>().currentIndex,
      onTap: (index) {
        bottomnavProvider.currentIndex = index;
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "User"),
        BottomNavigationBarItem(icon: Icon(Icons.message), label: "Message"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Setting")
      ],
    );
  }
}
