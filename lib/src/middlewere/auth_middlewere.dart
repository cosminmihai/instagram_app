import 'package:instagram_app/src/actions/auth/login.dart';
import 'package:instagram_app/src/actions/auth/logout.dart';
import 'package:instagram_app/src/actions/auth/registration.dart';
import 'package:instagram_app/src/actions/auth/reserve_username.dart';
import 'package:instagram_app/src/actions/auth/reset_password.dart';
import 'package:instagram_app/src/actions/auth/send_sms.dart';
import 'package:instagram_app/src/data/authentication_api.dart';
import 'package:instagram_app/src/models/app_state.dart';
import 'package:instagram_app/src/models/app_user.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class AuthMiddleware {
  AuthMiddleware({@required this.authApi});

  final AuthApi authApi;

  List<Middleware<AppState>> get middleware {
    return <Middleware<AppState>>[
      TypedMiddleware<AppState, Login>(_login),
      TypedMiddleware<AppState, LogOut>(_logOut),
      TypedMiddleware<AppState, ResetPassword>(_resetPassword),
      TypedMiddleware<AppState, Registration>(_registration),
      TypedMiddleware<AppState, ReserveUsername>(_reserveUsername),
      TypedMiddleware<AppState, SendSms>(_sendSms),
    ];
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
      action.result(successfulAction);
    } catch (error) {
      store.dispatch(ResetPasswordError(error));
      action.result(ResetPasswordError(error));
    }
  }

  Future<void> _registration(Store<AppState> store, Registration action, NextDispatcher next) async {
    next(action);
    try {
      final AppUser user = await authApi.register(store.state.info);
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

  Future<void> _sendSms(Store<AppState> store, SendSms action, NextDispatcher next) async {
    next(action);

    try {
      final String verificationId = await authApi.sendSms(store.state.info.phone);
      final SendSmsSuccessful successful = SendSmsSuccessful(verificationId);
      store.dispatch(successful);
      action.result(successful);
    } catch (e) {
      final SendSmsError error = SendSmsError(e);
      store.dispatch(error);
      action.result(error);
      print(error.toString());
    }
  }
}
