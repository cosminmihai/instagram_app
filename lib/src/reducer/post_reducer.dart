import 'package:instagram_app/src/actions/post/create_post.dart';
import 'package:instagram_app/src/actions/post/listen_for_posts.dart';
import 'package:instagram_app/src/actions/post/update_post_info.dart';
import 'package:instagram_app/src/models/posts/post_state.dart';
import 'package:redux/redux.dart';

Reducer<PostsState> postReducer = combineReducers<PostsState>(<Reducer<PostsState>>[
  TypedReducer<PostsState, CreatePostSuccessful>(_createPostSuccessful),
  TypedReducer<PostsState, UpdatePostInfo>(_updatePostInfo),
  TypedReducer<PostsState, OnPostsEvent>(_onPostEvent),
]);

PostsState _createPostSuccessful(PostsState state, CreatePostSuccessful action) {
  return state.rebuild((PostsStateBuilder b) {
    b.savePostInfo = null;
  });
}

PostsState _updatePostInfo(PostsState state, UpdatePostInfo action) {
  return state.rebuild((PostsStateBuilder b) => b.savePostInfo = action.info.toBuilder());
}

PostsState _onPostEvent(PostsState state, OnPostsEvent action) {
  return state.rebuild((PostsStateBuilder b) {
    b.posts = action.posts.toBuilder();
  });
}
