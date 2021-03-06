library serializer;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:instagram_app/src/models/app_state.dart';
import 'package:instagram_app/src/models/auth/app_user.dart';
import 'package:instagram_app/src/models/auth/auth_state.dart';
import 'package:instagram_app/src/models/auth/registration_info.dart';
import 'package:instagram_app/src/models/chats/chat.dart';
import 'package:instagram_app/src/models/chats/chats_state.dart';
import 'package:instagram_app/src/models/chats/message.dart';
import 'package:instagram_app/src/models/comments/comment.dart';
import 'package:instagram_app/src/models/comments/comments_state.dart';
import 'package:instagram_app/src/models/likes/like.dart';
import 'package:instagram_app/src/models/likes/like_state.dart';
import 'package:instagram_app/src/models/likes/like_type.dart';
import 'package:instagram_app/src/models/posts/post.dart';
import 'package:instagram_app/src/models/posts/post_state.dart';
import 'package:instagram_app/src/models/posts/save_post_info.dart';

part 'serializers.g.dart';

@SerializersFor(<Type>[
  AppState,
  AppUser,
  RegistrationInfo,
  Post,
  SavePostInfo,
  Comparable,
  AuthState,
  PostsState,
  CommentsState,
  LikesState,
  Like,
  Message,
  LikeType,
  ChatsState,
  Chat,
  Message,
])
Serializers serializers = (_$serializers.toBuilder() //
      ..addPlugin(StandardJsonPlugin()))
    .build();
