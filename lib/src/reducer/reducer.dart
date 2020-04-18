import 'package:instagram_app/src/actions/initialize_app.dart';
import 'package:instagram_app/src/actions/login.dart';
import 'package:instagram_app/src/actions/logout.dart';
import 'package:instagram_app/src/actions/registration.dart';
import 'package:instagram_app/src/models/app_state.dart';

AppState reducer(AppState state, dynamic action) {
  if (action is InitializeAppSuccessful) {
    return state.copyWith(user: action.user);
  } else if (action is LoginSuccessful) {
    return state.copyWith(user: action.user);
  } else if (action is LogOutSuccessful) {
    return const AppState();
  } else if (action is RegistrationSuccessful) {
    return state.copyWith(user: action.user);
  } else if (action is LogOutSuccessful) {
    return const AppState();
  } else {
    return state;
  }
}
