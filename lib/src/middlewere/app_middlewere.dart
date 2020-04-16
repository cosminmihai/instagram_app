import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:instagram_app/src/actions/initialize_app.dart';
import 'package:instagram_app/src/actions/login.dart';
import 'package:instagram_app/src/actions/logout.dart';
import 'package:instagram_app/src/actions/reset_password.dart';
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
    } else if (action is Login) {
      final FirebaseUser firebaseUser = await authApi.login(action.email, action.password);
      final AppUser appUser = AppUser(
        uid: firebaseUser.uid,
        displayName: firebaseUser.displayName,
        username: null,
        email: firebaseUser.email,
        birthDate: null,
        photoUrl: firebaseUser.photoUrl,
      );
      store.dispatch(LoginSuccessful(appUser));
    } else if (action is LogOut) {
      await authApi.logOut();
      store.dispatch(LogOutSuccessful());
    } else if (action is ResetPassword) {
      await authApi.sendEmailPasswordRecovery(action.email);
      final ResetPasswordSuccessful successfulAction = ResetPasswordSuccessful();
      store.dispatch(successfulAction);
      action.actionResult(successfulAction);
    }
  }
}