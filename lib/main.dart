import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:instagram_app/src/actions/initialize_app.dart';
import 'package:instagram_app/src/data/authentication_api.dart';
import 'package:instagram_app/src/data/post_api.dart';
import 'package:instagram_app/src/epics/app_epics.dart';
import 'package:instagram_app/src/models/app_state.dart';
import 'package:instagram_app/src/presentation/add_post_page.dart';
import 'package:instagram_app/src/presentation/forgot_password.dart';
import 'package:instagram_app/src/presentation/home.dart';
import 'package:instagram_app/src/presentation/home_page.dart';
import 'package:instagram_app/src/presentation/login_page.dart';
import 'package:instagram_app/src/presentation/post_details.dart';
import 'package:instagram_app/src/presentation/signup_screens/signup_page.dart';
import 'package:instagram_app/src/reducer/reducer.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final AuthApi authApi = AuthApi(auth: FirebaseAuth.instance, firestore: Firestore.instance);
  final PostApi postApi = PostApi(firestore: Firestore.instance, storage: FirebaseStorage.instance);
  final AppEpics epics = AppEpics(authApi: authApi, postApi: postApi);
  final Store<AppState> store = Store<AppState>(
    reducer,
    initialState: AppState(),
    middleware: <Middleware<AppState>>[
      EpicMiddleware<AppState>(epics.epics),
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
          'loginPage': (BuildContext context) => const LoginPage(),
          'homepage': (BuildContext context) => HomePage(),
          'forgotPassword': (BuildContext context) => ForgotPasswordPage(),
          'signUpPage': (BuildContext context) => const SignUpPage(),
          'addPhotoPage': (BuildContext context) => AddPostPage(),
          '/postDetails': (BuildContext context) => const PostDetails(),
        },
      ),
    );
  }
}
