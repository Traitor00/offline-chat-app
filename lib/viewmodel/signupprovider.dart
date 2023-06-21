import 'package:chatapp/helpers/databasehelpers.dart';
import 'package:chatapp/model/user.dart';
import 'package:chatapp/view/signinpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';

class SignupViewModel extends ChangeNotifier {
  ///Text Editing Controller for Signup Page
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  var imagetemporary;

  ///Function to pick Image
  Future getimage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imagetemporary = image.path;
    this.imagetemporary = imagetemporary;
  }

  ///Function to Signup
  void signUp(BuildContext context) async {
    String name = nameController.text;
    String email = emailController.text;
    String password = passwordController.text;

    /// Validate username and password
    if (name.isEmpty || password.isEmpty || email.isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Error'),
          content: Text('Please enter a email and password.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(ctx).pop(),
            ),
          ],
        ),
      );
      return;
    }

    /// Save user to database

    DatabaseHelper dbHelper = DatabaseHelper();
    final User user = User(
        name: name, email: email, password: password, imageUrl: imagetemporary);
    await dbHelper.insertUser(user);

    /// Navigate to SignIn page
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SignInPage()));
  }
}
