import 'package:instagram_app/src/actions/actions.dart';
import 'package:instagram_app/src/models/app_state.dart';
import 'package:instagram_app/src/reducer/auth_reducer.dart';
import 'package:instagram_app/src/reducer/post_reducer.dart';
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
  authReducer,
  postReducer,
]);
