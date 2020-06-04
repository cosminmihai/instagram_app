import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:instagram_app/src/actions/initialize_app.dart';
import 'package:instagram_app/src/data/authentication_api.dart';
import 'package:instagram_app/src/data/chats_api.dart';
import 'package:instagram_app/src/data/comments_api.dart';
import 'package:instagram_app/src/data/like_api.dart';
import 'package:instagram_app/src/data/post_api.dart';
import 'package:instagram_app/src/epics/app_epics.dart';
import 'package:instagram_app/src/models/app_state.dart';
import 'package:instagram_app/src/presentation/chats/chats_page.dart';
import 'package:instagram_app/src/presentation/chats/messages_page.dart';
import 'package:instagram_app/src/presentation/home/add_comment_page.dart';
import 'package:instagram_app/src/presentation/home/add_post_page.dart';
import 'package:instagram_app/src/presentation/forgot_password.dart';
import 'package:instagram_app/src/presentation/home.dart';
import 'package:instagram_app/src/presentation/home/home_page.dart';
import 'package:instagram_app/src/presentation/home/profile/users_lists.dart';
import 'package:instagram_app/src/presentation/login_page.dart';
import 'package:instagram_app/src/presentation/home/post_details.dart';
import 'package:instagram_app/src/presentation/signup_screens/signup_page.dart';
import 'package:instagram_app/src/reducer/reducer.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:algolia/algolia.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  const Algolia algolia = Algolia.init(applicationId: 'KDH7Q4ILAX', apiKey: 'd6a6db4ca16c4675e9a8f1f42c593cef');
  final AlgoliaIndexReference index = algolia.index('users');
  final AuthApi authApi = AuthApi(
      auth: FirebaseAuth.instance,
      firestore: Firestore.instance,
      index: index,
      cloudFunctions: CloudFunctions.instance);
  final PostApi postApi = PostApi(firestore: Firestore.instance, storage: FirebaseStorage.instance);
  final CommentsApi commentsApi = CommentsApi(firestore: Firestore.instance);
  final LikeApi likeApi = LikeApi(firestore: Firestore.instance);
  final ChatsApi chatsApi = ChatsApi(firestore: Firestore.instance);
  final AppEpics epics =
      AppEpics(authApi: authApi, postApi: postApi, commentsApi: commentsApi, likeApi: likeApi, chatApi: chatsApi);
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
        onGenerateTitle: (BuildContext context) {
          initializeDateFormatting(Localizations.localeOf(context).toString());
          return 'Instagram Clone';
        },
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        routes: <String, WidgetBuilder>{
          'loginPage': (BuildContext context) => const LoginPage(),
          'homepage': (BuildContext context) => HomePage(),
          'forgotPassword': (BuildContext context) => ForgotPasswordPage(),
          'signUpPage': (BuildContext context) => const SignUpPage(),
          'addPhotoPage': (BuildContext context) => AddPostPage(),
          '/postDetails': (BuildContext context) => const PostDetails(),
          '/commentsPage': (_) => const CommentsPage(),
          '/usersList': (_) => const UsersList(),
          '/messages': (_) => const MessagesPage(),
          '/chats': (_) => const ChatsPage(),
        },
      ),
    );
  }
}
