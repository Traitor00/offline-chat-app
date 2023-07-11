import 'package:chatapp/helpers/database_helpers.dart';
import 'package:chatapp/model/user.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SignupViewModel extends ChangeNotifier {
  // Text Editing Controller for Signup Page
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController moilenoController = TextEditingController();
  // Ignore: prefer_typing_uninitialized_variables
  String? imagetemporary;
  // Function to pick Image
  Future getimage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imagetemporary = image.path;
    this.imagetemporary = imagetemporary;
  }

  // Function to Signup
  void signUp() async {
    String name = nameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String phoneno = moilenoController.text;
    // Save user to database
    DatabaseHelper dbHelper = DatabaseHelper();
    final User user = User(
        name: name,
        email: email,
        password: password,
        imageUrl: imagetemporary,
        phoneno: phoneno);
    await dbHelper.insertUser(user);
  }

// Function to validate user input
  String? validatorFuction(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }
}
