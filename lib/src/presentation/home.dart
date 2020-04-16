import 'package:flutter/material.dart';
import 'package:instagram_app/src/containers/user_container.dart';
import 'package:instagram_app/src/models/app_user.dart';
import 'package:instagram_app/src/presentation/home_page.dart';
import 'package:instagram_app/src/presentation/login_page.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return UserContainer(
      builder: (BuildContext context, AppUser user) {
        return user != null ? HomePage() : LoginPage();
      },
    );
  }
}

