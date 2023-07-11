import 'package:chatapp/helpers/database_helpers.dart';
import 'package:chatapp/model/combined.dart';
import 'package:chatapp/model/user.dart';
import 'package:flutter/material.dart';

class HomePageViewModel extends ChangeNotifier {
  int? _userId;
  int get userId => _userId!;
  set userId(int userId) {
    _userId = userId;
  }

  /// This function is for fetching message to display in homepages messages tabbar of message nav
  Future<List<Combined>> messageFetch() async {
    DatabaseHelper dbHelper = DatabaseHelper();
    return await dbHelper.fetchMessagesSortedByDate(userId);
  }

  /// Function to fetch logged in users profile
  Future<User?> fetchUserProfile() async {
    DatabaseHelper dbHelper = DatabaseHelper();
    return await dbHelper.getUserById(userId);
  }
}
