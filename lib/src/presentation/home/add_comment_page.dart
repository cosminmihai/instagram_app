import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:instagram_app/src/actions/comments/create_comment.dart';
import 'package:instagram_app/src/actions/comments/listen_for_comments.dart';
import 'package:instagram_app/src/actions/likes/create_like.dart';
import 'package:instagram_app/src/actions/likes/delete_like.dart';
import 'package:instagram_app/src/containers/comment_container.dart';
import 'package:instagram_app/src/containers/commets_likes_container.dart';
import 'package:instagram_app/src/containers/contacts_container.dart';
import 'package:instagram_app/src/containers/selected_posts_container.dart';
import 'package:instagram_app/src/containers/user_container.dart';
import 'package:instagram_app/src/models/app_state.dart';
import 'package:instagram_app/src/models/auth/app_user.dart';
import 'package:instagram_app/src/models/comments/comment.dart';
import 'package:instagram_app/src/models/likes/like.dart';
import 'package:instagram_app/src/models/likes/like_type.dart';
import 'package:instagram_app/src/models/posts/post.dart';
import 'package:redux/redux.dart';

class CommentsPage extends StatefulWidget {
  const CommentsPage({Key key}) : super(key: key);

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  final TextEditingController controller = TextEditingController();
  Store<AppState> store;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      store = StoreProvider.of<AppState>(context).dispatch(ListenForComments());
    });
  }

  void _result(dynamic action) {
    if (action is CreateCommentSuccessful) {
      controller.clear();
    } else {
      // todo: show error
    }
  }

  @override
  void dispose() {
    store.dispatch(StopListenForComments());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ContactsContainer(
      builder: (BuildContext context, Map<String, AppUser> contacts) {
        return SelectedPostContainer(
          builder: (BuildContext context, Post post) {
            return Scaffold(
              appBar: AppBar(
                title: Text(contacts[post.uid].displayName),
              ),
              body: Column(
                children: <Widget>[
                  Flexible(
                    child: UserContainer(
                      builder: (BuildContext context, AppUser currentUser) {
                        return CommentsLikesContainer(
                          builder: (BuildContext context, BuiltMap<String, BuiltList<Like>> likes) {
                            return CommentsContainer(
                              builder: (BuildContext context, List<Comment> comments) {
                                if (comments.isEmpty) {
                                  return const Center(
                                    child: Text('Be the first to comment.'),
                                  );
                                }
                                return ListView.builder(
                                  itemCount: comments.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    final Comment comment = comments[index];
                                    final AppUser contact = contacts[comment.uid];
                                    final BuiltList<Like> commentsLike = likes[comment.id] ?? BuiltList<Like>();
                                    final Like currentUserLike = commentsLike
                                        .firstWhere((Like like) => like.uid == comment.uid, orElse: () => null);

                                    return ListTile(
                                      title: Text(comment.text),
                                      subtitle: Text(comment.createdAt.toIso8601String()),
                                      trailing: Container(
                                        width: 64.0,
                                        child: Row(
                                          children: <Widget>[
                                            IconButton(
                                              icon: Icon(
                                                  currentUserLike != null ? Icons.favorite : Icons.favorite_border),
                                              onPressed: () {
                                                if (currentUserLike != null) {
                                                  StoreProvider.of<AppState>(context).dispatch(DeleteLike(
                                                      likeId: currentUserLike.id,
                                                      parentId: currentUserLike.parentId,
                                                      type: LikeType.comment));
                                                } else {
                                                  StoreProvider.of<AppState>(context)
                                                      .dispatch(CreateLike(comment.id, LikeType.comment));
                                                }
                                              },
                                            ),
                                            if (commentsLike.isNotEmpty) Text('${commentsLike.length}')
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const Divider(),
                  Form(
                    child: SafeArea(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16.0),
                        padding: const EdgeInsetsDirectional.only(bottom: 16.0),
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              child: TextFormField(
                                controller: controller,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Try a longer comment.';
                                  }

                                  return null;
                                },
                              ),
                            ),
                            Builder(
                              builder: (BuildContext context) {
                                return IconButton(
                                  icon: const Icon(Icons.send),
                                  onPressed: () {
                                    if (Form.of(context).validate()) {
                                      StoreProvider.of<AppState>(context)
                                          .dispatch(CreateComment(controller.text, _result));
                                    }
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
