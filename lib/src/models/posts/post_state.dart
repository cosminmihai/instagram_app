library post_state;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:instagram_app/src/models/posts/post.dart';
import 'package:instagram_app/src/models/posts/save_post_info.dart';
import 'package:instagram_app/src/models/serializers.dart';

part 'post_state.g.dart';

abstract class PostsState implements Built<PostsState, PostsStateBuilder> {
  factory PostsState([void Function(PostsStateBuilder b) updates]) = _$PostsState;

  factory PostsState.fromJson(Map<dynamic, dynamic> json) => serializers.deserializeWith(serializer, json);

  PostsState._();

  BuiltMap<String, Post> get posts;

  @nullable
  SavePostInfo get savePostInfo;

  @nullable
  String get selectedPostId;

  Map<String, dynamic> get json => serializers.serializeWith(serializer, this);

  static Serializer<PostsState> get serializer => _$postsStateSerializer;
}
