import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:instagram_app/src/actions/auth/logout.dart';
import 'package:instagram_app/src/models/app_state.dart';
import 'package:instagram_app/src/presentation/add_post_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  TabController tabController;

  void onItemTapped(int index) {
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute<void>(
            fullscreenDialog: true,
            builder: (BuildContext context) {
              return AddPostPage();
            }),
      );
    } else {
      setState(() {
        _selectedIndex = index;
        if (index > 2) {
          tabController.index = index - 1;
        } else {
          tabController.index = index;
        }
      });
    }
  }

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

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
            },
          ),
        ],
      ),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          Container(color: Colors.red),
          Container(color: Colors.blue),
          Container(color: Colors.white),
          Container(color: Colors.green),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: onItemTapped,
          selectedItemColor: Theme.of(context).accentColor,
          unselectedItemColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text('Search'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle),
              title: Text('Add photo'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              title: Text('Notification'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              title: Text('Profile'),
            ),
          ]),
    );
  }
}
