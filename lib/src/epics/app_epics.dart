import 'package:instagram_app/src/actions/actions.dart';
import 'package:instagram_app/src/actions/chats/listen_for_chats.dart';
import 'package:instagram_app/src/actions/initialize_app.dart';
import 'package:instagram_app/src/data/authentication_api.dart';
import 'package:instagram_app/src/data/chats_api.dart';
import 'package:instagram_app/src/data/comments_api.dart';
import 'package:instagram_app/src/data/like_api.dart';
import 'package:instagram_app/src/data/post_api.dart';
import 'package:instagram_app/src/epics/auth_epics.dart';
import 'package:instagram_app/src/epics/chat_epics.dart';
import 'package:instagram_app/src/epics/comments_epics.dart';
import 'package:instagram_app/src/epics/post_epics.dart';
import 'package:instagram_app/src/models/app_state.dart';
import 'package:instagram_app/src/models/auth/app_user.dart';
import 'package:meta/meta.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

import 'likes_epics.dart';

class AppEpics {
  const AppEpics({
    @required AuthApi authApi,
    @required PostApi postApi,
    @required CommentsApi commentsApi,
    @required LikeApi likeApi,
    @required ChatsApi chatApi,
  })  : assert(authApi != null),
        assert(postApi != null),
        assert(commentsApi != null),
        assert(likeApi != null),
        assert(chatApi != null),
        _authApi = authApi,
        _postApi = postApi,
        _commentsApi = commentsApi,
        _likeApi = likeApi,
        _chatApi = chatApi;

  final AuthApi _authApi;
  final PostApi _postApi;
  final CommentsApi _commentsApi;
  final LikeApi _likeApi;
  final ChatsApi _chatApi;

  Epic<AppState> get epics {
    return combineEpics(<Epic<AppState>>[
      TypedEpic<AppState, InitializeApp>(_initializeApp),
      AuthEpics(authApi: _authApi).epics,
      PostEpics(postApi: _postApi).epics,
      CommentsEpics(commentsApi: _commentsApi).epics,
      LikesEpics(likeApi: _likeApi).epics,
      ChatsEpics(chatsApi: _chatApi).epics,
    ]);
  }

  Stream<AppAction> _initializeApp(Stream<InitializeApp> actions, EpicStore<AppState> store) {
    return actions //
        .flatMap((InitializeApp action) => _authApi
            .getUser()
            .asStream()
            .expand<AppAction>((AppUser user) => <AppAction>[
                  InitializeAppSuccessful(user),
                  if (user != null) ListenForChats(),
                ])
            .onErrorReturnWith((dynamic error) => InitializeAppError(error)));
  }
}
