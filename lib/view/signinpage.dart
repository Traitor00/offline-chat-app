import 'package:chatapp/viewmodel/signinviewmodel.dart';
import 'package:chatapp/widgets/custom_textField.dart';
import 'package:chatapp/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    SignInViewModel signinprovider =
        Provider.of<SignInViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ///email TextField
            CustomTextField(
              editcontroller: signinprovider.emailController,
              labelText: "email",
              obscureText: false,
            ),

            ///Password TextField
            CustomTextField(
              editcontroller: signinprovider.passwordController,
              labelText: "password",
              obscureText: true,
            ),

            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => signinprovider.signIn(context),
              child: Text('Sign In'),
            ),

            CustomText(
              content: "Do not have account:",
              size: 16,
            ),
            GestureDetector(
                onTap: () => signinprovider.redirectSignupPage(context),
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
