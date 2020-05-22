library create_like.dart;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:instagram_app/src/actions/actions.dart';

part 'create_like.g.dart';

abstract class CreateLike //
    implements
        Built<CreateLike, CreateLikeBuilder>,
        AppAction //
{
  factory CreateLike([void Function(CreateLikeBuilder b) updates]) =
      _$CreateLike;

  CreateLike._();


}

abstract class CreateLikeSuccessful //
    implements
        Built<CreateLikeSuccessful, CreateLikeSuccessfulBuilder>,
        AppAction //
{
  factory CreateLikeSuccessful(
          [void Function(CreateLikeSuccessfulBuilder b) updates]) =
      _$CreateLikeSuccessful;

  CreateLikeSuccessful._();
}

abstract class CreateLikeError //
    implements
        Built<CreateLikeError, CreateLikeErrorBuilder>,
        ErrorAction //
{
  factory CreateLikeError(Object error) {
    return _$CreateLikeError((CreateLikeErrorBuilder b) => b.error = error);
  }

  CreateLikeError._();

  @override
  Object get error;
}
