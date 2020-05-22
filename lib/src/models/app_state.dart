library app_state;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:instagram_app/src/models/auth/auth_state.dart';
import 'package:instagram_app/src/models/comments/comments_state.dart';
import 'package:instagram_app/src/models/likes/like_state.dart';
import 'package:instagram_app/src/models/posts/post_state.dart';
import 'package:instagram_app/src/models/serializers.dart';

part 'app_state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  factory AppState([void Function(AppStateBuilder b) updates]) = _$AppState;

  factory AppState.fromJson(Map<dynamic, dynamic> json) =>
      serializers.deserializeWith(serializer, json);

  AppState._();

  AuthState get auth;

  PostsState get posts;

  CommentsState get comments;

  LikesState get likes;

  Map<String, dynamic> get json => serializers.serializeWith(serializer, this);

  static Serializer<AppState> get serializer => _$appStateSerializer;
}
