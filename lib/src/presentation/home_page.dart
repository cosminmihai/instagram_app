import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:instagram_app/src/actions/logout.dart';
import 'package:instagram_app/src/models/app_state.dart';

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
              StoreProvider.of<AppState>(context).dispatch(LogOut());
              await Navigator.pushReplacementNamed(context, 'loginpage');
            },
          ),
        ],
      ),
    );
  }
}
