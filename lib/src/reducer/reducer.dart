import 'package:instagram_app/src/actions/actions.dart';
import 'package:instagram_app/src/actions/logout.dart';
import 'package:instagram_app/src/actions/reserve_username.dart';
import 'package:instagram_app/src/actions/send_sms.dart';
import 'package:instagram_app/src/actions/update_registration_info.dart';
import 'package:instagram_app/src/models/app_state.dart';
import 'package:redux/redux.dart';

AppState reducer(AppState state, dynamic action) {
  final AppState result = _reducer(state, action);

  if (action is ErrorAction) {
    final dynamic error = action.error;
    try {
      print('Error: ${error}');
      print('StackTrace: ${error.stackTrace}');
    } catch (_) {}
  }
  print('${action.runtimeType} => $result');
  return result;
}

Reducer<AppState> _reducer = combineReducers<AppState>(<Reducer<AppState>>[
  TypedReducer<AppState, UserAction>(_userAction),
  TypedReducer<AppState, LogOutSuccessful>(_logoutSuccessful),
  TypedReducer<AppState, UpdateRegistrationInfo>(_updateRegistrationInfo),
  TypedReducer<AppState, ReserveUsernameSuccessful>(_reserveUsernameSuccessful),
  TypedReducer<AppState, SendSmsSuccessful>(_sendSmsSuccessful),
]);

AppState _userAction(AppState state, UserAction action) {
  return state.rebuild((AppStateBuilder b) {
    b.user = action.user?.toBuilder();
  });
}

AppState _logoutSuccessful(AppState state, LogOutSuccessful action) {
  return AppState();
}

AppState _updateRegistrationInfo(AppState state, UpdateRegistrationInfo action) {
  return state.rebuild((AppStateBuilder b) => b.info = action.info.toBuilder());
}

AppState _reserveUsernameSuccessful(AppState state, ReserveUsernameSuccessful action) {
  return state.rebuild((AppStateBuilder b) => b.info.username = action.username);
}

AppState _sendSmsSuccessful(AppState state, SendSmsSuccessful action) {
  return state.rebuild((AppStateBuilder b) => b.info.verificationId = action.verificationId);
}
