import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:instagram_app/src/models/app_state.dart';
import 'package:instagram_app/src/models/auth/app_user.dart';
import 'package:redux/redux.dart';

class UserContainer extends StatelessWidget {
  const UserContainer({Key key, @required this.builder}) : super(key: key);

  final ViewModelBuilder<AppUser> builder;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppUser>(
      converter: (Store<AppState> store) => store.state.auth.user,
      builder: builder,
    );
  }
}
