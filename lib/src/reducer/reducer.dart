import 'package:instagram_app/src/actions/actions.dart';
import 'package:instagram_app/src/actions/initialize_app.dart';
import 'package:instagram_app/src/actions/login.dart';
import 'package:instagram_app/src/actions/logout.dart';
import 'package:instagram_app/src/actions/registration.dart';
import 'package:instagram_app/src/actions/reserve_username.dart';
import 'package:instagram_app/src/actions/send_sms.dart';
import 'package:instagram_app/src/actions/update_registration_info.dart';
import 'package:instagram_app/src/models/app_state.dart';
import 'package:instagram_app/src/models/registration_info.dart';
import 'package:redux/redux.dart';

AppState reducer(AppState state, dynamic action) {
  if (action is ErrorAction) {
    print('error: ${action.error}');
  }
  final AppState result = _reducer(state, action);
  print('${action.runtimeType} => $result');
  return result;
}

Reducer<AppState> _reducer = combineReducers<AppState>(<Reducer<AppState>>[
  TypedReducer<AppState, InitializeAppSuccessful>(_initializeAppSuccessful),
  TypedReducer<AppState, LoginSuccessful>(_loginSuccessful),
  TypedReducer<AppState, LogOutSuccessful>(_logoutSuccessful),
  TypedReducer<AppState, RegistrationSuccessful>(_signUpSuccessful),
  TypedReducer<AppState, UpdateRegistrationInfo>(_updateRegistrationInfo),
  TypedReducer<AppState, ReserveUsernameSuccessful>(_reserveUsernameSuccessful),
  TypedReducer<AppState, SendSmsSuccessful>(_sendSmsSuccessful),
]);

AppState _initializeAppSuccessful(AppState state, InitializeAppSuccessful action) {
  return state.copyWith(user: action.user);
}

AppState _loginSuccessful(AppState state, LoginSuccessful action) {
  return state.copyWith(user: action.user);
}

AppState _logoutSuccessful(AppState state, LogOutSuccessful action) {
  return const AppState();
}

AppState _signUpSuccessful(AppState state, RegistrationSuccessful action) {
  return state.copyWith(user: action.user);
}

AppState _updateRegistrationInfo(AppState state, UpdateRegistrationInfo action) {
  return state.copyWith(info: action.info);
}

AppState _reserveUsernameSuccessful(AppState state, ReserveUsernameSuccessful action) {
  final RegistrationInfo registrationInfo = state.info.copyWith(username: action.username);
  return state.copyWith(info: registrationInfo);
}

AppState _sendSmsSuccessful(AppState state, SendSmsSuccessful action) {
  final RegistrationInfo registrationInfo = state.info.copyWith(verificationId: action.verificationId);
  return state.copyWith(info: registrationInfo);
}
