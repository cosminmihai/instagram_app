import 'package:instagram_app/src/actions/actions.dart';
import 'package:instagram_app/src/actions/likes/create_like.dart';
import 'package:instagram_app/src/actions/likes/get_likes.dart';
import 'package:instagram_app/src/data/like_api.dart';
import 'package:instagram_app/src/models/app_state.dart';
import 'package:instagram_app/src/models/likes/delete_like.dart';
import 'package:instagram_app/src/models/likes/like.dart';
import 'package:meta/meta.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

class LikesEpics {
  const LikesEpics({
    @required LikeApi likeApi,
  })  : assert(likeApi != null),
        _likeApi = likeApi;

  final LikeApi _likeApi;

  Epic<AppState> get epics {
    return combineEpics(<Epic<AppState>>[
      TypedEpic<AppState, CreateLike>(_createLike),
      TypedEpic<AppState, DeleteLike>(_deleteLike),
      TypedEpic<AppState, GetLikes>(_getLikes),
    ]);
  }

  Stream<AppAction> _createLike(Stream<CreateLike> actions, EpicStore<AppState> store) {
    return actions.flatMap((CreateLike action) => _likeApi
        .create(uid: store.state.auth.user.uid, parentId: action.parentId, type: action.type)
        .asStream()
        .map<AppAction>((Like like) => CreateLikeSuccessful(like))
        .onErrorReturnWith((dynamic error) => CreateLikeError(error)));
  }

  Stream<AppAction> _getLikes(Stream<GetLikes> actions, EpicStore<AppState> store) {
    return actions //
        .flatMap((GetLikes action) => _likeApi
            .getLikes(action.parentId)
            .asStream()
            .map<AppAction>((List<Like> likes) => GetLikesSuccessful(likes, action.parentId))
            .onErrorReturnWith((dynamic error) => GetLikesError(error)));
  }

  Stream<AppAction> _deleteLike(Stream<DeleteLike> actions, EpicStore<AppState> store) {
    return actions //
        .flatMap((DeleteLike action) => _likeApi
            .delete(action.likeId)
            .asStream()
            .map<AppAction>((_) => DeleteLikeSuccessful(
                  likeId: action.likeId,
                  parentId: action.parentId,
                  type: action.type,
                ))
            .onErrorReturnWith((dynamic error) => DeleteLikeError(error)));
  }
}
