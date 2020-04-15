import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_app/src/data/authentication_api.dart';
import 'package:instagram_app/src/presentation/forgot_password.dart';
import 'package:instagram_app/src/presentation/home_page.dart';
import 'package:instagram_app/src/presentation/login_page.dart';
import 'package:instagram_app/src/presentation/home.dart';

AuthApi auth;

void main() {
  auth = AuthApi(auth: FirebaseAuth.instance);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      theme: ThemeData.dark().copyWith(
        backgroundColor: Colors.black,
      ),
      routes: <String, WidgetBuilder>{
        'loginpage': (BuildContext context) => LoginPage(),
        'homepage': (BuildContext context) => HomePage(),
        'forgotPassword': (BuildContext context) => ForgotPasswordPage()
      },
    );
  }
}
