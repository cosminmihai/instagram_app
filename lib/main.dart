import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_app/src/authentication_api.dart';
import 'package:instagram_app/src/home_page.dart';
import 'package:instagram_app/src/login_page.dart';

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
        'homepage': (BuildContext context) => HomePage()
      },
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  Future<void> getUser() async {
    final FirebaseUser user = await auth.getUser();
    setState(() {
      isLoggedIn = user != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoggedIn ? HomePage() : LoginPage();
  }
}
