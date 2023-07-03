import 'package:chatapp/widgets/homescreen/tabbar/call_inside_tabbar.dart';
import 'package:chatapp/widgets/homescreen/tabbar/group_in_tabbar.dart';
import 'package:chatapp/widgets/homescreen/tabbar/message_inside_tab.dart';
import 'package:chatapp/widgets/homescreen/tabbar/tabbar_indicator.dart';
import 'package:chatapp/widgets/text.dart';
import 'package:flutter/material.dart';

///class show item of navbar and inside this we inserted tabbar
class MessagesList extends StatelessWidget {
  const MessagesList({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          shadowColor: Colors.white70,
          backgroundColor: Colors.white54,
          automaticallyImplyLeading: false,
          title: Text(
            "All Chats",
            style: TextStyle(color: Colors.black),
          ),
          bottom: TabBar(
              indicatorPadding: EdgeInsets.only(right: 5, top: 15),
              indicator: DotIndicator(color: Colors.blue, radius: 5),
              tabs: const [
                Tab(child: CustomText(content: "Message", size: 20)),
                Tab(child: CustomText(content: "Group", size: 20)),
                Tab(child: CustomText(content: "Call", size: 20)),
              ]),
          actions: const [
            Icon(
              Icons.search,
              color: Colors.black,
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.person_add,
              color: Colors.black,
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
        body: TabBarView(children: const [
          MessageinsideTabbar(),
          Groups(),
          Call(),
        ]),
      ),
    );
  }
}
