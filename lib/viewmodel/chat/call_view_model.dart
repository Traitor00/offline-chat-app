import 'package:chatapp/helpers/database_helpers.dart';
import 'package:chatapp/model/call_history.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class CallViewModel extends ChangeNotifier {
  int? _receiverid;
  int get receiverid => _receiverid ?? 0;
  set receiverid(int receiverid) {
    _receiverid = receiverid;
  }

  int? _senderid;
  int get senderid => _senderid ?? 0;
  set senderid(int senderid) {
    _senderid = senderid;
  }

  String? _callerno;
  String? _receiverno;
  String get callerno => _callerno ?? '';
  set callerno(String callerno) {
    callerno = _callerno ?? '';
  }

  String get receiverno => _receiverno ?? '';
  set receiverno(String receiverno) {
    receiverno = _receiverno ?? "";
  }

  /// Fuction to get receivers mobile no
  Future<String?> getReceiverNumber() async {
    DatabaseHelper dbHelper = DatabaseHelper();
    _receiverno = await dbHelper.getUserNumer(receiverid);

    return await dbHelper.getUserNumer(receiverid);
  }

  /// To get senders number
  Future<String?> getSenderNumber() async {
    DatabaseHelper dbHelper = DatabaseHelper();
    _callerno = await dbHelper.getUserNumer(senderid);

    return await dbHelper.getUserNumer(senderid);
  }

  /// Using url launcher to open phone app in mobile
  Future<void> makePhoneCall() async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: receiverno,
    );

    await launchUrl(launchUri);
  }

  /// To add call history to database
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

  /// Fetch call history
  Future<List<CallHistory>> fetchCallHistory() async {
    DatabaseHelper dbHelper = DatabaseHelper();
    return await dbHelper.getCallHistory(callerno);
  }
}
