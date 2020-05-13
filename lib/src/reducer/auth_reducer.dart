import 'package:instagram_app/src/actions/actions.dart';
import 'package:instagram_app/src/actions/auth/logout.dart';
import 'package:instagram_app/src/actions/auth/reserve_username.dart';
import 'package:instagram_app/src/actions/auth/send_sms.dart';
import 'package:instagram_app/src/actions/auth/update_registration_info.dart';
import 'package:instagram_app/src/models/auth/auth_state.dart';
import 'package:redux/redux.dart';

Reducer<AuthState> authReducer = combineReducers<AuthState>(<Reducer<AuthState>>[
  TypedReducer<AuthState, UserAction>(_userAction),
  TypedReducer<AuthState, LogOutSuccessful>(_logoutSuccessful),
  TypedReducer<AuthState, UpdateRegistrationInfo>(_updateRegistrationInfo),
  TypedReducer<AuthState, ReserveUsernameSuccessful>(_reserveUsernameSuccessful),
  TypedReducer<AuthState, SendSmsSuccessful>(_sendSmsSuccessful),
]);

AuthState _userAction(AuthState state, UserAction action) {
  return state.rebuild((AuthStateBuilder b) {
    b.user = action.user?.toBuilder();
  });
}

AuthState _logoutSuccessful(AuthState state, LogOutSuccessful action) {
  return AuthState();
}

AuthState _updateRegistrationInfo(AuthState state, UpdateRegistrationInfo action) {
  return state.rebuild((AuthStateBuilder b) => b.info = action.info.toBuilder());
}

AuthState _reserveUsernameSuccessful(AuthState state, ReserveUsernameSuccessful action) {
  return state.rebuild((AuthStateBuilder b) => b.info.username = action.username);
}

AuthState _sendSmsSuccessful(AuthState state, SendSmsSuccessful action) {
  return state.rebuild((AuthStateBuilder b) => b.info.verificationId = action.verificationId);
}
