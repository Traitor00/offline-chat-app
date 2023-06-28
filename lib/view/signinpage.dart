import 'package:chatapp/view/signuppage.dart';
import 'package:chatapp/viewmodel/signinviewmodel.dart';
import 'package:chatapp/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Consumer<SignInViewModel>(
              builder: (context, model, _) => TextField(
                controller: model.emailController,
                decoration: InputDecoration(labelText: 'email'),
              ),
            ),
            Consumer<SignInViewModel>(
              ///Build a widget tree based on the value from a provider.
              builder: (context, model, _) => TextField(
                controller: model.passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
            ),
            SizedBox(height: 16),
            Consumer<SignInViewModel>(
              builder: (context, model, _) => ElevatedButton(
                onPressed: () => model.signIn(context),
                child: Text('Sign In'),
              ),
            ),
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
    );
  }
}
