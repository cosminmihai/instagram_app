import 'package:instagram_app/src/actions/initialize_app.dart';
import 'package:instagram_app/src/models/app_state.dart';

AppState reducer(AppState state, dynamic action) {
  if (action is InitializeAppSuccessful) {
    return state.copyWith(user: action.user);
  } else {
    return state;
  }
}
