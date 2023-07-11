import 'package:chatapp/helpers/database_helpers.dart';
import 'package:chatapp/model/user.dart';
import 'package:flutter/material.dart';

class SignInViewModel extends ChangeNotifier {
  // Textediting controllers for email and password textfields
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  int? _userid;
  int get userid => _userid!;
  bool? _userNotFound;
  bool get userNotFound => _userNotFound!;

  // Function to Signin and send user id got from database to another
  // Page i.e Home Page
  Future<bool> signIn() async {
    String email = emailController.text;
    String password = passwordController.text;
    DatabaseHelper dbHelper = DatabaseHelper();
    final List<User> users = await dbHelper.isUserExist(email, password);
    // Checks if userid is returned or not to check user exist or not
    if (users.isEmpty) {
      return false;
    } else {
      _userid = users[0].id?.toInt();
      return true;
    }
  }

// Function to validate user input
  String? validatorFuction(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }
}
