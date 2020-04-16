import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:instagram_app/src/actions/initialize_app.dart';
import 'package:instagram_app/src/data/authentication_api.dart';
import 'package:instagram_app/src/models/app_state.dart';
import 'package:instagram_app/src/models/app_user.dart';
import 'package:redux/redux.dart';
import 'package:meta/meta.dart';

class AppMiddleware extends MiddlewareClass<AppState> {
  AppMiddleware({@required this.authApi});

  final AuthApi authApi;

  @override
  Future<void> call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    next(action);
    if (action is InitializeApp) {
      final FirebaseUser provideUser = await authApi.getUser();
      final AppUser appUser = AppUser(
        uid: provideUser.uid,
        displayName: provideUser.displayName,
        username: null,
        email: provideUser.email,
        birthDate: null,
        photoUrl: provideUser.photoUrl,
      );
      store.dispatch(InitializeAppSuccessful(appUser));
    }
  }
}
