import 'package:chatapp/helpers/databasehelpers.dart';
import 'package:chatapp/model/callhistory.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class CallViewModel extends ChangeNotifier {
  int? _receiverid;
  int get receiverid => _receiverid!;
  set receiverid(int receiverid) {
    _receiverid = receiverid;
  }

  int? _senderid;
  int get senderid => _senderid!;
  set senderid(int senderid) {
    _senderid = senderid;
  }

  String? _callerno;
  String? _receiverno;
  String get callerno => _callerno!;
  set callerno(String callerno) {
    callerno = _callerno!;
  }

  String get receiverno => _receiverno!;
  set receiverno(String receiverno) {
    receiverno = _receiverno!;
  }

  Future<String?> getReceiverNumber() async {
    DatabaseHelper dbHelper = DatabaseHelper();
    _receiverno = await dbHelper.getUserNumer(receiverid);
    print("receiver no: ${_receiverno}");

    return await dbHelper.getUserNumer(receiverid);
  }

  Future<String?> getSenderNumber() async {
    DatabaseHelper dbHelper = DatabaseHelper();
    _callerno = await dbHelper.getUserNumer(senderid);
    print("caller no: ${_callerno}");
    return await dbHelper.getUserNumer(senderid);
  }

  ///using url launcher to open phone app in mobile
  Future<void> makePhoneCall() async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: receiverno,
    );
    print("make phonecall:${receiverno}");
    await launchUrl(launchUri);
  }

  void callHistoryAdd() async {
    DatabaseHelper dbHelper = DatabaseHelper();
    final CallHistory callHistory = CallHistory(
      callerno: callerno,
      receiverno: receiverno,
      calledat: DateTime.now().toIso8601String(),
    );

    await dbHelper.createCallHistory(callHistory);

    notifyListeners();
  }

  ///fetch call history
  Future<List<CallHistory>> fetchCallHistory() async {
    DatabaseHelper dbHelper = DatabaseHelper();
    return await dbHelper.getCallHistory(callerno);
  }
}
