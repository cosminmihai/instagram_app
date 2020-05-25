import 'package:built_collection/built_collection.dart';
import 'package:instagram_app/src/actions/likes/create_like.dart';
import 'package:instagram_app/src/actions/likes/get_likes.dart';
import 'package:instagram_app/src/models/likes/delete_like.dart';
import 'package:instagram_app/src/models/likes/like.dart';
import 'package:instagram_app/src/models/likes/like_state.dart';
import 'package:instagram_app/src/models/likes/like_type.dart';
import 'package:redux/redux.dart';

Reducer<LikesState> likeReducer = combineReducers<LikesState>(<Reducer<LikesState>>[
  TypedReducer<LikesState, CreateLikeSuccessful>(_createLikeSuccessful),
  TypedReducer<LikesState, DeleteLikeSuccessful>(_deleteLikeSuccessful),
  TypedReducer<LikesState, GetLikesSuccessful>(_getLikesSuccessful),
]);

LikesState _createLikeSuccessful(LikesState state, CreateLikeSuccessful action) {
  return state.rebuild((LikesStateBuilder b) {
    if (action.like.type == LikeType.post) {
      final ListBuilder<Like> list = b.posts[action.like.id]?.toBuilder() ?? ListBuilder<Like>();

      if (!list.build().contains(action.like)) {
        list.add(action.like);
      }
      print(list.build());
      b.posts[action.like.parentId] = list.build();
    } else if (action.like.type == LikeType.comment) {
      final ListBuilder<Like> list = b.comments[action.like.parentId]?.toBuilder() ?? ListBuilder<Like>();
      if (!list.build().contains(action.like)) {
        list.add(action.like);
      }
      b.comments[action.like.parentId] = list.build();
    } else {
      throw ArgumentError('Unknown like type: ${action.like.type}');
    }
  });
}

LikesState _getLikesSuccessful(LikesState state, GetLikesSuccessful action) {
  return state.rebuild((LikesStateBuilder b) {
    if (action.likes.isEmpty) {
      b.comments[action.parentId] = BuiltList<Like>();
      b.posts[action.parentId] = BuiltList<Like>();
    } else {
      final LikeType type = action.likes[0].type;

      if (type == LikeType.post) {
        b.posts[action.parentId] = BuiltList<Like>(action.likes);
      } else if (type == LikeType.comment) {
        b.comments[action.parentId] = BuiltList<Like>(action.likes);
      } else {
        throw ArgumentError('Unknown like type ${type}');
      }
    }
  });
}

LikesState _deleteLikeSuccessful(LikesState state, DeleteLikeSuccessful action) {
  return state.rebuild((LikesStateBuilder b) {
    if (action.type == LikeType.post) {
      final ListBuilder<Like> likes = b.posts[action.parentId].toBuilder();
      likes.removeWhere((Like item) => item.id == action.likeId);
      b.posts[action.parentId] = likes.build();
    } else if (action.type == LikeType.comment) {
      final ListBuilder<Like> likes = b.comments[action.parentId].toBuilder();
      likes.removeWhere((item) => item.id == action.likeId);
      b.comments[action.parentId] = likes.build();
    } else {
      throw ArgumentError('Unknown like type ${action.type}');
    }
  });
}
