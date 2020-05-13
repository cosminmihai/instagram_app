import 'package:instagram_app/src/actions/actions.dart';
import 'package:instagram_app/src/models/app_state.dart';
import 'package:instagram_app/src/reducer/auth_reducer.dart';
import 'package:instagram_app/src/reducer/comments_reducer.dart';
import 'package:instagram_app/src/reducer/post_reducer.dart';

AppState reducer(AppState state, dynamic action) {
  if (action is ErrorAction) {
    final dynamic error = action.error;
    try {
      print('Error: ${error}');
      print('StackTrace: ${error.stackTrace}');
    } catch (_) {}
  }
  print(action);
  return state.rebuild((b) {
    b
      ..auth = authReducer(state.auth, action).toBuilder()
      ..posts = postReducer(state.posts, action).toBuilder()
      ..comments = commentsReducer(state.comments, action).toBuilder();
  });
}
