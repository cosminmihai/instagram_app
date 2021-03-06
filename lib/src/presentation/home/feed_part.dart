import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:instagram_app/src/actions/likes/create_like.dart';
import 'package:instagram_app/src/actions/likes/delete_like.dart';
import 'package:instagram_app/src/actions/post/listen_for_posts.dart';
import 'package:instagram_app/src/actions/post/set.dart';
import 'package:instagram_app/src/containers/contacts_container.dart';
import 'package:instagram_app/src/containers/posts_container.dart';
import 'package:instagram_app/src/containers/posts_likes_container.dart';
import 'package:instagram_app/src/containers/user_container.dart';
import 'package:instagram_app/src/models/app_state.dart';
import 'package:instagram_app/src/models/auth/app_user.dart';
import 'package:instagram_app/src/models/likes/like.dart';
import 'package:instagram_app/src/models/likes/like_type.dart';
import 'package:instagram_app/src/models/posts/post.dart';
import 'package:intl/intl.dart';
import 'package:redux/redux.dart';

class FeedPart extends StatefulWidget {
  const FeedPart({Key key}) : super(key: key);

  @override
  _FeedPartState createState() => _FeedPartState();
}

class _FeedPartState extends State<FeedPart> {
  Store<AppState> store;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      store = StoreProvider.of<AppState>(context);
      store.state.auth.user.following //
          .map((String uid) => ListenForPosts(uid))
          .forEach(store.dispatch);
    });
  }

  @override
  void dispose() {
    store.state.auth.user.following //
        .map((String uid) => StopListeningForPosts(uid))
        .forEach(store.dispatch);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UserContainer(
      builder: (BuildContext context, AppUser currentUser) {
        return ContactsContainer(
          builder: (BuildContext context, Map<String, AppUser> contacts) {
            return PostContainer(
              builder: (BuildContext context, List<Post> posts) {
                final DateFormat dayFormat = DateFormat.yMMMMd().add_Hm();
                final DateFormat hourFormat = DateFormat.Hm();
                return PostsLikesContainer(
                  builder: (BuildContext context, BuiltMap<String, BuiltList<Like>> likes) {
                    if (likes.isEmpty) {
                      return Scaffold(
                        appBar: AppBar(
                          actions: <Widget>[
                            IconButton(
                              icon: const Icon(Icons.message),
                              onPressed: () {
                                Navigator.pushNamed(context, '/chats');
                              },
                            ),
                          ],
                        ),
                        body: const Center(
                          child: Text('No posts yet.'),
                        ),
                      );
                    }
                    return Scaffold(
                      appBar: AppBar(
                        actions: <Widget>[
                          IconButton(
                            icon: const Icon(Icons.message),
                            onPressed: () {
                              Navigator.pushNamed(context, '/chats');
                            },
                          ),
                        ],
                      ),
                      body: posts.isEmpty
                          ? const Center(
                              child: Text('No posts yet.'),
                            )
                          : ListView.builder(
                              itemCount: posts.length,
                              itemBuilder: (BuildContext context, int index) {
                                final Post post = posts[index];
                                final BuiltList<Like> postLikes = likes[post.id] ?? BuiltList<Like>();
                                final Like currentUserLike = postLikes
                                    .firstWhere((Like like) => like.uid == currentUser.uid, orElse: () => null);
                                final bool containsLike = currentUserLike != null;
                                final AppUser user = contacts[post.uid];
                                String date;
                                if (DateTime.now().difference(post.createdAt) > const Duration(days: 1)) {
                                  date = dayFormat.format(post.createdAt);
                                } else {
                                  date = hourFormat.format(post.createdAt);
                                }
                                return Container(
                                  height: MediaQuery.of(context).size.height / 2,
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        title: Text(user.displayName),
                                        subtitle: Text('@${user.username}'),
                                      ),
                                      Expanded(
                                        child: Image.network(
                                          post.pictures.first,
                                          fit: BoxFit.cover,
                                          width: MediaQuery.of(context).size.width,
                                        ),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              IconButton(
                                                icon: containsLike
                                                    ? const Icon(Icons.favorite)
                                                    : const Icon(Icons.favorite_border),
                                                onPressed: () {
                                                  if (containsLike) {
                                                    StoreProvider.of<AppState>(context).dispatch(DeleteLike(
                                                        parentId: post.id,
                                                        likeId: currentUserLike.id,
                                                        type: LikeType.post));
                                                  } else {
                                                    StoreProvider.of<AppState>(context)
                                                        .dispatch(CreateLike(post.id, LikeType.post));
                                                  }
                                                },
                                              ),
                                              if (postLikes.isNotEmpty) Text('${postLikes.length}'),
                                            ],
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.chat_bubble_outline),
                                            onPressed: () {
                                              StoreProvider.of<AppState>(context).dispatch(SetSelectedPost(post.id));
                                              Navigator.pushNamed(context, '/commentsPage');
                                            },
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.send),
                                            onPressed: () {},
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            icon: const Icon(Icons.bookmark_border),
                                            onPressed: () {},
                                          )
                                        ],
                                      ),
                                      ListTile(
                                        title: Text(post.description),
                                        subtitle: Text(date),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
