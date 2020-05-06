import 'package:flutter/cupertino.dart';
import 'package:instagram_app/src/actions/initialize_app.dart';
import 'package:instagram_app/src/data/authentication_api.dart';
import 'package:instagram_app/src/data/post_api.dart';
import 'package:instagram_app/src/middlewere/auth_middlewere.dart';
import 'package:instagram_app/src/middlewere/post_middlewere.dart';
import 'package:instagram_app/src/models/app_state.dart';
import 'package:instagram_app/src/models/app_user.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class AppMiddleware {
  AppMiddleware({@required this.postApi, @required this.authApi});

  final AuthApi authApi;
  final PostApi postApi;

  List<Middleware<AppState>> get middleware {
    return <Middleware<AppState>>[
      TypedMiddleware<AppState, InitializeApp>(_initializeApp),
      ...AuthMiddleware(authApi: authApi).middleware,
      ...PostMiddleware(postApi: postApi).middleware,
    ];
  }

  Future<void> _initializeApp(Store<AppState> store, InitializeApp action, NextDispatcher next) async {
    next(action);
    try {
      final AppUser user = await authApi.getUser();
      store.dispatch(InitializeAppSuccessful(user));
    } catch (error) {
      store.dispatch(InitializeAppError(error));
    }
  }
}
