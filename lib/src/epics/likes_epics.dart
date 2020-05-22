import 'package:instagram_app/src/actions/actions.dart';
import 'package:instagram_app/src/actions/likes/create_like.dart';
import 'package:instagram_app/src/data/like_api.dart';
import 'package:instagram_app/src/models/app_state.dart';
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
    ]);
  }

  Stream<AppAction> _createLike(
      Stream<CreateLike> actions, EpicStore<AppState> store) {
    return actions.flatMap((CreateLike action) => _likeApi
        .create(
            uid: store.state.auth.user.uid,
            parentId: action.parentId,
            type: action.type)
        .asStream()
        .map<AppAction>((Like like) => CreateLikeSuccessful(like))
        .onErrorReturnWith((dynamic error) => CreateLikeError(error)));
  }
}
