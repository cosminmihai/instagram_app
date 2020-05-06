import 'package:flutter/cupertino.dart';
import 'package:instagram_app/src/actions/post/create_post.dart';
import 'package:instagram_app/src/data/post_api.dart';
import 'package:instagram_app/src/models/app_state.dart';
import 'package:instagram_app/src/models/post.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class PostMiddleware {
  PostMiddleware({@required this.postApi});

  final PostApi postApi;

  List<Middleware<AppState>> get middleware {
    return <Middleware<AppState>>[
      TypedMiddleware<AppState, CreatePost>(_createPost),
    ];
  }

  Future<void> _createPost(Store<AppState> store, CreatePost action, NextDispatcher next) async {
    next(action);
    try {
      final Post post = await postApi.createPost(
        uid: store.state.user.uid,
        description: action.description,
        pictures: action.pictures.toList(),
      );
      final CreatePostSuccessful _result = CreatePostSuccessful(post);
      store.dispatch(CreatePostSuccessful(post));
      action.result(_result);
    } catch (error) {
      final CreatePostError _result = CreatePostError(error);
      store.dispatch(CreatePostError(error));
      action.result(_result);
    }
  }
}
