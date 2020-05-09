import 'package:instagram_app/src/actions/actions.dart';
import 'package:instagram_app/src/actions/initialize_app.dart';
import 'package:instagram_app/src/data/authentication_api.dart';
import 'package:instagram_app/src/data/post_api.dart';
import 'package:instagram_app/src/epics/auth_epics.dart';
import 'package:instagram_app/src/epics/post_epics.dart';
import 'package:instagram_app/src/models/app_state.dart';
import 'package:instagram_app/src/models/app_user.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';
import 'package:meta/meta.dart';

class AppEpics {
  const AppEpics({
    @required AuthApi authApi,
    @required PostApi postApi,
  })  : assert(authApi != null),
        assert(postApi != null),
        _authApi = authApi,
        _postApi = postApi;

  final AuthApi _authApi;

  final PostApi _postApi;

  Epic<AppState> get epics {
    return combineEpics(<Epic<AppState>>[
      TypedEpic<AppState, InitializeApp>(_initializeApp),
      AuthEpics(authApi: _authApi).epics,
      PostEpics(postApi: _postApi).epics,
    ]);
  }

  Stream<AppAction> _initializeApp(Stream<InitializeApp> actions, EpicStore<AppState> store) {
    return actions //
        .asyncMap((InitializeApp action) => _authApi.getUser())
        .map<AppAction>((AppUser user) => InitializeAppSuccessful(user))
        .onErrorReturnWith((dynamic error) => InitializeAppError(error));
  }
}
