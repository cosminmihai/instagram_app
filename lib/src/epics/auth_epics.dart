import 'package:instagram_app/src/actions/actions.dart';
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
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

class AuthEpics {
  const AuthEpics({@required AuthApi authApi})
      : assert(authApi != null),
        _authApi = authApi;

  final AuthApi _authApi;

  Epic<AppState> get epics {
    return combineEpics(<Epic<AppState>>[
      TypedEpic<AppState, Login>(_login),
      TypedEpic<AppState, LogOut>(_logout),
      TypedEpic<AppState, ResetPassword>(_resetPassword),
      TypedEpic<AppState, Registration>(_signUp),
      TypedEpic<AppState, ReserveUsername>(_reserveUsername),
      TypedEpic<AppState, SendSms>(_sendSms),
    ]);
  }

  Stream<AppAction> _login(Stream<Login> actions, EpicStore<AppState> store) {
    return actions //
        .flatMap((Login action) => _authApi
            .login(action.email, action.password)
            .asStream()
            .map<AppAction>((AppUser user) => LoginSuccessful(user))
            .onErrorReturnWith((dynamic error) => LoginError(error)));
  }

  Stream<AppAction> _logout(Stream<LogOut> actions, EpicStore<AppState> store) {
    return actions //
        .flatMap((LogOut action) => _authApi
            .logOut()
            .asStream()
            .mapTo<AppAction>(LogOutSuccessful())
            .onErrorReturnWith((dynamic error) => LogOutError(error)));
  }

  Stream<AppAction> _resetPassword(Stream<ResetPassword> actions, EpicStore<AppState> store) {
    return actions //
        .flatMap((ResetPassword action) => _authApi
            .sendEmailPasswordRecovery(action.email)
            .asStream()
            .map<AppAction>((_) => ResetPasswordSuccessful())
            .onErrorReturnWith((dynamic error) => ResetPasswordError(error))
            .doOnData(action.result));
  }

  Stream<AppAction> _signUp(Stream<Registration> actions, EpicStore<AppState> store) {
    return actions //
        .flatMap((Registration action) => _authApi
            .register(store.state.info)
            .asStream()
            .map<AppAction>((AppUser user) => RegistrationSuccessful(user))
            .onErrorReturnWith((dynamic error) => RegistrationError(error))
            .doOnData(action.result));
  }

  Stream<AppAction> _reserveUsername(Stream<ReserveUsername> actions, EpicStore<AppState> store) {
    return actions //
        .flatMap((ReserveUsername action) => _authApi
            .reserveUsername(email: store.state.info.email, displayName: store.state.info.displayName)
            .asStream()
            .map<AppAction>((String username) => ReserveUsernameSuccessful(username))
            .onErrorReturnWith((dynamic error) => ReserveUsernameError(error)));
  }

  Stream<AppAction> _sendSms(Stream<SendSms> actions, EpicStore<AppState> store) {
    return actions //
        .flatMap((SendSms action) => _authApi
            .sendSms(store.state.info.phone)
            .asStream()
            .map<AppAction>((String verificationId) => SendSmsSuccessful(verificationId))
            .onErrorReturnWith((dynamic error) => SendSmsError(error))
            .doOnData(action.result));
  }
}
