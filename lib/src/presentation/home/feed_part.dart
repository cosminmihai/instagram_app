import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:instagram_app/src/actions/post/set.dart';
import 'package:instagram_app/src/containers/contacts_container.dart';
import 'package:instagram_app/src/containers/posts_container.dart';
import 'package:instagram_app/src/models/app_state.dart';
import 'package:instagram_app/src/models/auth/app_user.dart';
import 'package:instagram_app/src/models/posts/post.dart';
import 'package:timeago/timeago.dart';

class FeedPart extends StatefulWidget {
  @override
  _FeedPartState createState() => _FeedPartState();
}

class _FeedPartState extends State<FeedPart> {
  @override
  Widget build(BuildContext context) {
    return ContactsContainer(
      builder: (BuildContext context, Map<String, AppUser> contact) {
        return PostContainer(
          builder: (BuildContext context, List<Post> posts) {
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (BuildContext context, int index) {
                final Post post = posts[index];
                final AppUser user = contact[post.uid];
                final DateTime localHour = DateTime.now();
                final DateTime createdAt = post.createdAt;
                final Duration diference = localHour.difference(createdAt);

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
                          IconButton(
                            icon: Icon(Icons.favorite_border),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.chat_bubble_outline),
                            onPressed: () {
                              StoreProvider.of<AppState>(context).dispatch(SetSelectedPost(post.id));
                              Navigator.pushNamed(context, '/commentsPage');
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.send),
                            onPressed: () {},
                          ),
                          const Spacer(),
                          IconButton(
                            icon: Icon(Icons.bookmark_border),
                            onPressed: () {},
                          )
                        ],
                      ),
                      ListTile(
                        title: Text(post.description),
                        subtitle: Text(format(localHour.subtract(diference))),
                      )
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
