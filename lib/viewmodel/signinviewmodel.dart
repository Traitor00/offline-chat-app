import 'package:chatapp/helpers/databasehelpers.dart';
import 'package:chatapp/model/user.dart';
import 'package:chatapp/view/Homepage.dart';
import 'package:flutter/material.dart';

class SignInViewModel extends ChangeNotifier {
  ///textediting controllers for email and password textfields
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  int? _userid;
  int get userid => _userid!;

  ///Function to Signin and send user id got from database to another page i.e Home Page
  void signIn(BuildContext context) async {
    String email = emailController.text;
    String password = passwordController.text;
    final String info = "Usernot found";

    ///validate username and password
    if (email.isEmpty || password.isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("error"),
          content: Text("please enter a emal and apsword"),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(ctx).pop(), child: Text("OK"))
          ],
        ),
      );
      return;
    }
    DatabaseHelper dbHelper = DatabaseHelper();
    final List<User> users = await dbHelper.isUserExist(email, password);

    ///Checks if userid is returned or not to check user exist or not
    if (users.isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("error"),
          content: Text("USer Donot Exist"),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(ctx).pop(), child: Text("OK"))
          ],
        ),
      );

      info;
    } else {
      _userid = users[0].id?.toInt();
      //navigate to home page
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => HomePage(
            userid: userid,
          ),
        ),
      );
    }
  }
}
