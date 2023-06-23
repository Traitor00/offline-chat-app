import 'package:chatapp/viewmodel/signupprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              Consumer<SignupViewModel>(
                builder: (context, model, _) => TextField(
                  controller: model.nameController,
                  decoration: InputDecoration(labelText: 'name'),
                ),
              ),
              Consumer<SignupViewModel>(
                builder: (context, model, _) => TextField(
                  controller: model.emailController,
                  decoration: InputDecoration(labelText: 'email'),
                ),
              ),
              Consumer<SignupViewModel>(
                builder: (context, model, _) => TextField(
                  controller: model.moilenoController,
                  decoration: InputDecoration(labelText: 'mobileno'),
                ),
              ),
              Consumer<SignupViewModel>(
                builder: (context, model, _) => TextField(
                  controller: model.passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Consumer<SignupViewModel>(
                builder: (context, model, _) => GestureDetector(
                  onTap: () {
                    model.getimage();
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
              ),
              SizedBox(height: 20),
              Consumer<SignupViewModel>(
                builder: (context, model, _) => Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () => model.signUp(context),
                      child: Text('Sign Up'),
                    ),
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
