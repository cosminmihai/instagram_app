library like_state;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:instagram_app/src/models/likes/like.dart';
import 'package:instagram_app/src/models/serializers.dart';


part 'like_state.g.dart';

abstract class LikesState implements Built<LikesState, LikesStateBuilder> {
  factory LikesState([void Function(LikesStateBuilder b) updates]) =
      _$LikesState;

  factory LikesState.fromJson(Map<dynamic, dynamic> json) =>
      serializers.deserializeWith(serializer, json);

  LikesState._();

  // postId => like
  BuiltMap<String, BuiltList<Like>> get posts;

  Map<String, dynamic> get json => serializers.serializeWith(serializer, this);

  static Serializer<LikesState> get serializer => _$likesStateSerializer;
}
