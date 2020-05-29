import 'package:instagram_app/src/actions/actions.dart';
import 'package:instagram_app/src/actions/auth/login.dart';
import 'package:instagram_app/src/actions/auth/logout.dart';
import 'package:instagram_app/src/actions/auth/registration.dart';
import 'package:instagram_app/src/actions/auth/reserve_username.dart';
import 'package:instagram_app/src/actions/auth/reset_password.dart';
import 'package:instagram_app/src/actions/auth/search_users.dart';
import 'package:instagram_app/src/actions/auth/send_sms.dart';
import 'package:instagram_app/src/actions/get_action.dart';
import 'package:instagram_app/src/data/authentication_api.dart';
import 'package:instagram_app/src/models/app_state.dart';
import 'package:instagram_app/src/models/auth/app_user.dart';
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
      TypedEpic<AppState, GetContact>(_getContact),
      TypedEpic<AppState, SearchUsers>(_searchUsers),
    ]);
  }

  Stream<AppAction> _login(Stream<Login> actions, EpicStore<AppState> store) {
    return actions //
        .flatMap((Login action) => _authApi
            .login(action.email, action.password)
            .asStream()
            .expand<AppAction>((AppUser user) => <AppAction>[
                  LoginSuccessful(user),
                  ...user.following //
                      .where((String uid) => store.state.auth.contacts[uid] == null)
                      .map((String uid) => GetContact(uid))
                      .toSet()
                ])
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
            .register(store.state.auth.info)
            .asStream()
            .map<AppAction>((AppUser user) => RegistrationSuccessful(user))
            .onErrorReturnWith((dynamic error) => RegistrationError(error))
            .doOnData(action.result));
  }

  Stream<AppAction> _reserveUsername(Stream<ReserveUsername> actions, EpicStore<AppState> store) {
    return actions //
        .flatMap((ReserveUsername action) => _authApi
            .reserveUsername(email: store.state.auth.info.email, displayName: store.state.auth.info.displayName)
            .asStream()
            .map<AppAction>((String username) => ReserveUsernameSuccessful(username))
            .onErrorReturnWith((dynamic error) => ReserveUsernameError(error)));
  }

  Stream<AppAction> _sendSms(Stream<SendSms> actions, EpicStore<AppState> store) {
    return actions //
        .flatMap((SendSms action) => _authApi
            .sendSms(store.state.auth.info.phone)
            .asStream()
            .map<AppAction>((String verificationId) => SendSmsSuccessful(verificationId))
            .onErrorReturnWith((dynamic error) => SendSmsError(error))
            .doOnData(action.result));
  }

  Stream<AppAction> _getContact(Stream<GetContact> actions, EpicStore<AppState> store) {
    return actions //
        .flatMap((GetContact action) => _authApi
            .getContacts(action.uid)
            .asStream()
            .map<AppAction>((AppUser contact) => GetContactSuccessful(contact))
            .onErrorReturnWith((dynamic error) => GetContactError(error)));
  }

  Stream<AppAction> _searchUsers(Stream<SearchUsers> actions, EpicStore<AppState> store) {
    actions //
        .debounceTime(const Duration(milliseconds: 300))
        .switchMap((SearchUsers action) => _authApi
            .searchUsers(action.query)
            .asStream()
            .map<AppAction>((List<AppUser> users) => SearchUsersSuccessful(users))
            .onErrorReturnWith((dynamic error) => SearchUsersError(error)));
  }
}
