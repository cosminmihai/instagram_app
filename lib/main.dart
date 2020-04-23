import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:instagram_app/src/actions/initialize_app.dart';
import 'package:instagram_app/src/data/authentication_api.dart';
import 'package:instagram_app/src/middlewere/app_middlewere.dart';
import 'package:instagram_app/src/models/app_state.dart';
import 'package:instagram_app/src/presentation/SignUp_screens/birthdate_screen4.dart';
import 'package:instagram_app/src/presentation/SignUp_screens/email_phone_screen1.dart';
import 'package:instagram_app/src/presentation/SignUp_screens/name_screen2.dart';
import 'package:instagram_app/src/presentation/SignUp_screens/password_screeen3.dart';
import 'package:instagram_app/src/presentation/SignUp_screens/welcome_screen5.dart';
import 'package:instagram_app/src/presentation/forgot_password.dart';
import 'package:instagram_app/src/presentation/home_page.dart';
import 'package:instagram_app/src/presentation/login_page.dart';
import 'package:instagram_app/src/presentation/home.dart';
import 'package:instagram_app/src/presentation/registration_page.dart';
import 'package:instagram_app/src/reducer/reducer.dart';
import 'package:redux/redux.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final AuthApi auth = AuthApi(auth: FirebaseAuth.instance, firestore: Firestore.instance);
  final AppMiddleware middleware = AppMiddleware(authApi: auth);
  final Store<AppState> store = Store<AppState>(
    reducer,
    initialState: const AppState(),
    middleware: <Middleware<AppState>>[
      middleware,
    ],
  )..dispatch(InitializeApp());
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
        home: const Home(),
        theme: ThemeData.dark(),
        routes: <String, WidgetBuilder>{
          'loginpage': (BuildContext context) => const LoginPage(),
          'homepage': (BuildContext context) => HomePage(),
          'forgotPassword': (BuildContext context) => ForgotPasswordPage(),
          'registerPage': (BuildContext context) => const RegisterPage(),
          'signUpEmailPhone': (BuildContext context) => const SignUpEmailPhone(),
          'signUpName': (BuildContext context) => const SignUpName(),
          'signUpPassword': (BuildContext context) => const SignUpPassword(),
          'signUpBirthDate': (BuildContext context) => const SignUpBirthDate(),
          'signUpWelcome': (BuildContext context) => const SignUpWelcome()
        },
      ),
    );
  }
}
