import 'package:chatapp/view/signin_page.dart';
import 'package:chatapp/viewmodel/signup_view_model.dart';
import 'package:chatapp/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SignupViewModel signUpProvider = context.read<SignupViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///name field
                TextFormField(
                    controller: signUpProvider.nameController,
                    decoration: InputDecoration(labelText: "name"),
                    obscureText: false,
                    validator: signUpProvider.validatorFuction),

                ///Email Field
                TextFormField(
                    controller: signUpProvider.emailController,
                    decoration: InputDecoration(labelText: "email"),
                    obscureText: false,
                    validator: signUpProvider.validatorFuction),

                ///Mobile no Text Field
                TextFormField(
                    controller: signUpProvider.moilenoController,
                    decoration: InputDecoration(labelText: "mobile no"),
                    obscureText: false,
                    validator: signUpProvider.validatorFuction),

                ///Password TextField
                TextFormField(
                    controller: signUpProvider.passwordController,
                    decoration: InputDecoration(labelText: "password"),
                    obscureText: true,
                    validator: signUpProvider.validatorFuction),
                SizedBox(
                  height: 16,
                ),

                ///Picking image
                _buildSelectImage(signUpProvider),
                SizedBox(height: 20),

                ///Signup Button
                _buildSignupButton(context, signUpProvider),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Center _buildSignupButton(
      BuildContext context, SignupViewModel signUpProvider) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 40,
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // If the form is valid, login.
              signUpProvider.signUp();

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SignInPage(),
                ),
              );
            }
          },
          child: Text('Sign Up'),
        ),
      ),
    );
  }

  GestureDetector _buildSelectImage(SignupViewModel signUpProvider) {
    return GestureDetector(
      onTap: () {
        signUpProvider.getimage();
      },
      child: Container(
        margin: EdgeInsets.only(left: 10),
        width: 100,
        color: Colors.blue,
        height: 30,
        child: Center(
          child: Text(
            "Select Image",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
