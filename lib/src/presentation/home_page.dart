import 'package:flutter/material.dart';
import 'package:instagram_app/main.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () async {
              await auth.logOut();
              await Navigator.pushReplacementNamed(context, 'loginpage');
            },
          ),
        ],
      ),
    );
  }
}
