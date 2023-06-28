import 'package:chatapp/helpers/databasehelpers.dart';
import 'package:chatapp/model/callhistory.dart';
import 'package:flutter/foundation.dart';
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

  ///Fuction to get receivers mobile no
  Future<String?> getReceiverNumber() async {
    DatabaseHelper dbHelper = DatabaseHelper();
    _receiverno = await dbHelper.getUserNumer(receiverid);
    if (kDebugMode) {
      print("receiver no: $_receiverno");
    }

    return await dbHelper.getUserNumer(receiverid);
  }

  ///to get senders number
  Future<String?> getSenderNumber() async {
    DatabaseHelper dbHelper = DatabaseHelper();
    _callerno = await dbHelper.getUserNumer(senderid);
    if (kDebugMode) {
      print("caller no: $_callerno");
    }
    return await dbHelper.getUserNumer(senderid);
  }

  ///using url launcher to open phone app in mobile
  Future<void> makePhoneCall() async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: receiverno,
    );
    if (kDebugMode) {
      print("make phonecall:$receiverno");
    }
    await launchUrl(launchUri);
  }

  ///To add call history to database
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
