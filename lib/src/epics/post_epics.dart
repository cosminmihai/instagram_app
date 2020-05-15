import 'package:instagram_app/src/actions/actions.dart';
import 'package:instagram_app/src/actions/get_action.dart';
import 'package:instagram_app/src/actions/post/create_post.dart';
import 'package:instagram_app/src/actions/post/listen_for_posts.dart';
import 'package:instagram_app/src/data/post_api.dart';
import 'package:instagram_app/src/models/app_state.dart';
import 'package:instagram_app/src/models/posts/post.dart';
import 'package:meta/meta.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

class PostEpics {
  const PostEpics({@required PostApi postApi})
      : assert(postApi != null),
        _postApi = postApi;

  final PostApi _postApi;

  Epic<AppState> get epics {
    return combineEpics(<Epic<AppState>>[
      TypedEpic<AppState, CreatePost>(_createPost),
      _listenForPosts,
    ]);
  }

  Stream<AppAction> _createPost(Stream<CreatePost> actions, EpicStore<AppState> store) {
    return actions //
        .flatMap((CreatePost action) => _postApi
            .createPost(
              uid: store.state.auth.user.uid,
              description: store.state.posts.savePostInfo.description,
              pictures: store.state.posts.savePostInfo.pictures.toList(),
            )
            .asStream()
            .map<AppAction>((Post post) => CreatePostSuccessful(post))
            .onErrorReturnWith((dynamic error) => CreatePostError(error))
            .doOnData(action.result));
  }

  Stream<AppAction> _listenForPosts(Stream<dynamic> actions, EpicStore<AppState> store) {
    return actions //
        .whereType<ListenForPosts>()
        .flatMap((ListenForPosts action) => _postApi
            .listen(store.state.auth.user.uid)
            .expand<AppAction>((List<Post> posts) {
              return <AppAction>[
                OnPostsEvent(posts),
                ...posts //
                    .where((Post post) => store.state.auth.contacts[post.uid] == null)
                    .map((Post user) => GetContact(user.uid))
                    .toSet()
              ];
            })
            .takeUntil(actions.whereType<StopListeningForPosts>())
            .onErrorReturnWith((dynamic error) => ListenForPostsError(error)));
  }
}
