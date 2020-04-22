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
      final AppUser user = await authApi.getUser();
      store.dispatch(InitializeAppSuccessful(user));
    } else if (action is Login) {
      final AppUser user = await authApi.login(action.email, action.password);
      store.dispatch(LoginSuccessful(user));
    } else if (action is LogOut) {
      await authApi.logOut();
      store.dispatch(LogOutSuccessful());
    } else if (action is ResetPassword) {
      await authApi.sendEmailPasswordRecovery(action.email);
      final ResetPasswordSuccessful successfulAction = ResetPasswordSuccessful();
      store.dispatch(successfulAction);
      action.actionResult(successfulAction);
    } else if (action is Registration) {
      final AppUser user = await authApi.register(action.email, action.password);
      final RegistrationSuccessful registrationSuccessful = RegistrationSuccessful(user);
      store.dispatch(registrationSuccessful);
      action.result(registrationSuccessful);
    }
  }
}
