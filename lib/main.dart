import 'package:chatapp/view/signin_page.dart';
import 'package:chatapp/viewmodel/chat/call_view_model.dart';
import 'package:chatapp/viewmodel/chat/chat_view_model.dart';
import 'package:chatapp/viewmodel/homepage/navbarviewmodel/navbar_view_model.dart';
import 'package:chatapp/viewmodel/homepage/home_page_view_model.dart';
import 'package:chatapp/viewmodel/homepage/navbarviewmodel/user_view_model.dart';
import 'package:chatapp/viewmodel/signin_view_model.dart';
import 'package:chatapp/viewmodel/signup_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<SignupViewModel>(create: (_) => SignupViewModel()),
      ChangeNotifierProvider<SignInViewModel>(create: (_) => SignInViewModel()),
      ChangeNotifierProvider<HomePageViewModel>(
          create: (_) => HomePageViewModel()),
      ChangeNotifierProvider<BottomNavigationBarProvider>(
          create: (_) => BottomNavigationBarProvider()),
      ChangeNotifierProvider<UserViewModel>(create: (_) => UserViewModel()),
      ChangeNotifierProvider<ChatProvider>(create: (_) => ChatProvider()),
      ChangeNotifierProvider<CallViewModel>(create: (_) => CallViewModel()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignInPage(),
    );
  }
}
