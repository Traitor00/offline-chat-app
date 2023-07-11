import 'package:chatapp/view/home_page.dart';
import 'package:chatapp/view/signup_page.dart';
import 'package:chatapp/viewmodel/signin_view_model.dart';
import 'package:chatapp/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SignInViewModel signInProvider = context.read<SignInViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              //email TextField
              TextFormField(
                controller: signInProvider.emailController,
                decoration: InputDecoration(labelText: "email"),
                obscureText: false,
                validator: signInProvider.validatorFuction,
              ),
              // Password TextField
              TextFormField(
                  controller: signInProvider.passwordController,
                  decoration: InputDecoration(labelText: "password"),
                  obscureText: true,
                  validator: signInProvider.validatorFuction),
              SizedBox(height: 16),
              _signInElevatedButton(signInProvider, context),
              CustomText(
                content: "Do not have account:",
                size: 16,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SignupPage(),
                      ),
                    );
                  },
                  child: Text(
                    "Signup",
                    style: TextStyle(color: Colors.blue),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  // String? _validatorFuction(value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Please enter some text';
  //   }
  //   return null;
  // }

  ElevatedButton _signInElevatedButton(
      SignInViewModel signInProvider, BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          // If the form is valid, login.
          bool loggedin = await signInProvider.signIn();

          if (!loggedin && context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('User Not Found')),
            );
          } else {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => HomePage(userid: signInProvider.userid),
              ),
            );
          }
        } else {
          return;
        }
      },
      child: Text('Sign In'),
    );
  }
}
