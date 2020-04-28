import 'package:flutter/cupertino.dart';
import 'package:instagram_app/src/actions/initialize_app.dart';
import 'package:instagram_app/src/actions/login.dart';
import 'package:instagram_app/src/actions/logout.dart';
import 'package:instagram_app/src/actions/registration.dart';
import 'package:instagram_app/src/actions/reserve_username.dart';
import 'package:instagram_app/src/actions/reset_password.dart';
import 'package:instagram_app/src/data/authentication_api.dart';
import 'package:instagram_app/src/models/app_state.dart';
import 'package:instagram_app/src/models/app_user.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class AppMiddleware {
  AppMiddleware({@required this.authApi});

  final AuthApi authApi;

  List<Middleware<AppState>> get middleware {
    return <Middleware<AppState>>[
      TypedMiddleware<AppState, InitializeApp>(_initializeApp),
      TypedMiddleware<AppState, Login>(_login),
      TypedMiddleware<AppState, LogOut>(_logOut),
      TypedMiddleware<AppState, ResetPassword>(_resetPassword),
      TypedMiddleware<AppState, Registration>(_registration),
      TypedMiddleware<AppState, ReserveUsername>(_reserveUsername),
    ];
  }

  Future<void> _initializeApp(Store<AppState> store, InitializeApp action, NextDispatcher next) async {
    next(action);
    try {
      final AppUser user = await authApi.getUser();
      store.dispatch(InitializeAppSuccessful(user));
    } catch (error) {
      store.dispatch(InitializeAppError(error));
    }
  }

  Future<void> _login(Store<AppState> store, Login action, NextDispatcher next) async {
    next(action);
    try {
      final AppUser user = await authApi.login(action.email, action.password);
      store.dispatch(LoginSuccessful(user));
    } catch (error) {
      store.dispatch(LoginError(error));
    }
  }

  Future<void> _logOut(Store<AppState> store, LogOut action, NextDispatcher next) async {
    next(action);
    try {
      await authApi.logOut();
      store.dispatch(LogOutSuccessful());
    } catch (error) {
      store.dispatch(LogOutError(error));
    }
  }

  Future<void> _resetPassword(Store<AppState> store, ResetPassword action, NextDispatcher next) async {
    next(action);
    try {
      await authApi.sendEmailPasswordRecovery(action.email);
      final ResetPasswordSuccessful successfulAction = ResetPasswordSuccessful();
      store.dispatch(successfulAction);
      action.actionResult(successfulAction);
    } catch (error) {
      store.dispatch(ResetPasswordError(error));
      action.actionResult(ResetPasswordError(error));
    }
  }

  Future<void> _registration(Store<AppState> store, Registration action, NextDispatcher next) async {
    next(action);
    try {
      final AppUser user = await authApi.register(action.email, action.password);
      final RegistrationSuccessful registrationSuccessful = RegistrationSuccessful(user);
      store.dispatch(registrationSuccessful);
      action.result(registrationSuccessful);
    } catch (error) {
      store.dispatch(RegistrationError(error));
      action.result(RegistrationError(error));
    }
  }

  Future<void> _reserveUsername(Store<AppState> store, ReserveUsername action, NextDispatcher next) async {
    next(action);
    try {
      final String username =
          await authApi.reserveUsername(email: store.state.info.email, displayName: store.state.info.displayName);
      store.dispatch(ReserveUsernameSuccessful(username));
    } catch (error) {
      store.dispatch(ReserveUsernameError(error));
    }
  }
}
