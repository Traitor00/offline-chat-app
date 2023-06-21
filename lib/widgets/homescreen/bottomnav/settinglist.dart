import 'package:chatapp/viewmodel/homepage/homepageviewmodel.dart';
import 'package:chatapp/widgets/customappbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingList extends StatelessWidget {
  const SettingList({super.key});

  @override
  Widget build(BuildContext context) {
    HomePageViewModel messageProvider =
        Provider.of<HomePageViewModel>(context, listen: false);
    return Scaffold(
        appBar: CustomAppBar(content: "Setting"),
        body: FutureBuilder(
            future: messageProvider.fetchUserProfile(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("Unable to fetch Profile Please login");
              } else if (snapshot.hasData) {
                final data = snapshot.data;
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 40,
                          child: Text(
                            data!.name![0],
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        "You are Logged in as:",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 15),
                      Text("Name: ${data.name}"),
                      SizedBox(height: 15),
                      Text("Email: ${data.email}"),
                    ],
                  ),
                );
              }
              return Text("Hello");
            }));
  }
}
