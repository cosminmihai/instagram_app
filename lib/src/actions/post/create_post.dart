library create_post;

import 'package:built_value/built_value.dart';
import 'package:instagram_app/src/actions/actions.dart';
import 'package:instagram_app/src/models/post.dart';

part 'create_post.g.dart';

abstract class CreatePost //
    implements
        Built<CreatePost, CreatePostBuilder>,
        AppAction //
{
  factory CreatePost(ActionResult actionResult) {
    return _$CreatePost((CreatePostBuilder b) {
      b.result = actionResult;
    });
  }

  CreatePost._();

  ActionResult get result;
}

abstract class CreatePostSuccessful //
    implements
        Built<CreatePostSuccessful, CreatePostSuccessfulBuilder>,
        AppAction //
{
  factory CreatePostSuccessful(Post post) {
    return _$CreatePostSuccessful((CreatePostSuccessfulBuilder b) {
      b.post = post.toBuilder();
    });
  }

  CreatePostSuccessful._();

  Post get post;
}

abstract class CreatePostError //
    implements
        Built<CreatePostError, CreatePostErrorBuilder>,
        ErrorAction //
{
  factory CreatePostError(Object error) {
    return _$CreatePostError((CreatePostErrorBuilder b) => b.error = error);
  }

  CreatePostError._();

  @override
  Object get error;
}
