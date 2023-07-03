import 'package:chatapp/view/signinpage.dart';
import 'package:chatapp/viewmodel/chat/callviewmodel.dart';
import 'package:chatapp/viewmodel/chat/insertchatviewmodel.dart';
import 'package:chatapp/viewmodel/homepage/navbarviewmodel/navbarviewmodel.dart';
import 'package:chatapp/viewmodel/homepage/homepageviewmodel.dart';
import 'package:chatapp/viewmodel/homepage/navbarviewmodel/userviewmodel.dart';
import 'package:chatapp/viewmodel/signinviewmodel.dart';
import 'package:chatapp/viewmodel/signupprovider.dart';
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
