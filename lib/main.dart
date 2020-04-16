import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:instagram_app/src/actions/initialize_app.dart';
import 'package:instagram_app/src/data/authentication_api.dart';
import 'package:instagram_app/src/middlewere/app_middlewere.dart';
import 'package:instagram_app/src/models/app_state.dart';
import 'package:instagram_app/src/presentation/forgot_password.dart';
import 'package:instagram_app/src/presentation/home_page.dart';
import 'package:instagram_app/src/presentation/login_page.dart';
import 'package:instagram_app/src/presentation/home.dart';
import 'package:instagram_app/src/reducer/reducer.dart';
import 'package:redux/redux.dart';

AuthApi auth;

void main() {
  final AuthApi auth = AuthApi(auth: FirebaseAuth.instance);
  final AppMiddleware middleware = AppMiddleware(authApi: auth);
  final Store<AppState> store = Store<AppState>(
    reducer,
    initialState: const AppState(),
    middleware: <Middleware<AppState>>[
      middleware,
    ],
  ).dispatch(InitializeApp());
  runApp(InstagramClone(store: store));
}

class InstagramClone extends StatelessWidget {
  const InstagramClone({Key key, this.store}) : super(key: key);

  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        home: Home(),
        theme: ThemeData.dark().copyWith(
          backgroundColor: Colors.black,
        ),
        routes: <String, WidgetBuilder>{
          'loginpage': (BuildContext context) => LoginPage(),
          'homepage': (BuildContext context) => HomePage(),
          'forgotPassword': (BuildContext context) => ForgotPasswordPage()
        },
      ),
    );
  }
}
