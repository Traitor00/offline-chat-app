import 'package:chatapp/viewmodel/chat/call_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class Call extends StatelessWidget {
  const Call({super.key});

  @override
  Widget build(BuildContext context) {
    CallViewModel callProvider = context.read<CallViewModel>();
    return FutureBuilder(
      future: callProvider.fetchCallHistory(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Something went Wrong");
        } else if (snapshot.hasData) {
          final data = snapshot.data ?? [];
          if (data.isEmpty) {
            return Center(child: Text("No Call History Found"));
          } else {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final callHistory = data[index];
                final DateTime time =
                    DateTime.parse(callHistory.calledat ?? '');
                return ListTile(
                  title: Text("You called ${callHistory.receiverno} "),
                  subtitle: Text(timeago.format(time)),
                );
              },
            );
          }
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
