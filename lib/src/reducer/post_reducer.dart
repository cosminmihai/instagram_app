import 'package:instagram_app/src/actions/post/create_post.dart';
import 'package:instagram_app/src/actions/post/update_post_info.dart';
import 'package:instagram_app/src/models/app_state.dart';
import 'package:redux/redux.dart';

Reducer<AppState> postReducer = combineReducers<AppState>(<Reducer<AppState>>[
  TypedReducer<AppState, CreatePostSuccessful>(_createPostSuccessful),
  TypedReducer<AppState, UpdatePostInfo>(_updatePostInfo),
]);

AppState _createPostSuccessful(AppState state, CreatePostSuccessful action) {
  return state.rebuild((AppStateBuilder b) {
    b
      ..posts.add(action.post)
      ..savePostInfo = null;
  });
}

AppState _updatePostInfo(AppState state, UpdatePostInfo action) {
  return state.rebuild((AppStateBuilder b) => b.savePostInfo = action.info.toBuilder());
}
