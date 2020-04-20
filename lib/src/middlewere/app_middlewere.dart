import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:instagram_app/src/actions/initialize_app.dart';
import 'package:instagram_app/src/actions/login.dart';
import 'package:instagram_app/src/actions/logout.dart';
import 'package:instagram_app/src/actions/registration.dart';
import 'package:instagram_app/src/actions/reset_password.dart';
import 'package:instagram_app/src/data/authentication_api.dart';
import 'package:instagram_app/src/models/app_state.dart';
import 'package:instagram_app/src/models/app_user.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class AppMiddleware extends MiddlewareClass<AppState> {
  AppMiddleware({@required this.authApi});

  final AuthApi authApi;

  @override
  Future<void> call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    next(action);
    if (action is InitializeApp) {
      final FirebaseUser firebaseUser = await authApi.getUser();
      if (firebaseUser == null) {
        store.dispatch(InitializeAppSuccessful(null));
      } else {
        final AppUser appUser = AppUser(
          uid: firebaseUser.uid,
          displayName: firebaseUser.displayName,
          username: null,
          email: firebaseUser.email,
          birthDate: null,
          photoUrl: firebaseUser.photoUrl,
        );
        store.dispatch(InitializeAppSuccessful(appUser));
      }
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
    } else if (action is Registration) {
      final FirebaseUser firebaseUser = await authApi.register(
        action.email,
        action.password,
      );
      final AppUser appUser = AppUser(
        uid: firebaseUser.uid,
        displayName: firebaseUser.displayName,
        username: action.userName,
        email: firebaseUser.email,
        birthDate: action.birthDate,
        photoUrl: firebaseUser.photoUrl,
      );
      final RegistrationSuccessful registrationSuccessful = RegistrationSuccessful(appUser);
      store.dispatch(registrationSuccessful);
      action.result(registrationSuccessful);
    }
  }
}
