import 'package:chatapp/viewmodel/signup_view_model.dart';
import 'package:chatapp/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    SignupViewModel signupProvider =
        Provider.of<SignupViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///name field
              CustomTextField(
                editcontroller: signupProvider.nameController,
                labelText: "name",
                obscureText: false,
              ),

              ///Email Field
              CustomTextField(
                editcontroller: signupProvider.emailController,
                labelText: "email",
                obscureText: false,
              ),

              ///Mobile no Text Field
              CustomTextField(
                editcontroller: signupProvider.moilenoController,
                labelText: "mobile no",
                obscureText: false,
              ),

              ///Password TextField
              CustomTextField(
                editcontroller: signupProvider.passwordController,
                labelText: "password",
                obscureText: true,
              ),
              SizedBox(
                height: 16,
              ),

              ///Picking image
              GestureDetector(
                onTap: () {
                  signupProvider.getimage();
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
                  )),
                ),
              ),
              SizedBox(height: 20),

              ///Signup Button
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () => signupProvider.signUp(context),
                    child: Text('Sign Up'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
