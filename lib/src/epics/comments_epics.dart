import 'package:instagram_app/src/actions/actions.dart';
import 'package:instagram_app/src/actions/comments/create_comment.dart';
import 'package:instagram_app/src/actions/comments/listen_for_comments.dart';
import 'package:instagram_app/src/actions/get_action.dart';
import 'package:instagram_app/src/data/comments_api.dart';
import 'package:instagram_app/src/models/app_state.dart';
import 'package:instagram_app/src/models/comments/comment.dart';
import 'package:meta/meta.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

class CommentsEpics {
  const CommentsEpics({@required CommentsApi commentsApi})
      : assert(commentsApi != null),
        _commentsApi = commentsApi;

  final CommentsApi _commentsApi;

  Epic<AppState> get epics {
    return combineEpics(<Epic<AppState>>[
      TypedEpic<AppState, CreateComment>(_createComment),
      _listenForComments,
    ]);
  }

  Stream<AppAction> _createComment(Stream<CreateComment> actions, EpicStore<AppState> store) {
    return actions //
        .flatMap((CreateComment action) => _commentsApi
            .create(
              uid: store.state.auth.user.uid,
              postId: store.state.posts.selectedPostId,
              text: action.text,
            )
            .asStream()
            .map<AppAction>((Comment comment) => CreateCommentSuccessful(comment))
            .onErrorReturnWith((dynamic error) => CreateCommentError(error))
            .doOnData(action.result));
  }

  Stream<AppAction> _listenForComments(Stream<dynamic> actions, EpicStore<AppState> store) {
    return actions //
        .whereType<ListenForComments>()
        .flatMap((ListenForComments action) => _commentsApi
            .listen(store.state.posts.selectedPostId)
            .expand<AppAction>((List<Comment> comments) => <AppAction>[
                  OnCommentsEvent(comments),
                  ...comments
                      .where((Comment element) => store.state.auth.contacts[element.uid] == null)
                      .map((Comment comment) => GetContact(comment.uid))
                      .toSet()
                ])
            .takeUntil(actions.whereType<StopListenForComments>())
            .onErrorReturnWith((dynamic error) => ListenForCommentsError(error)));
  }
}
