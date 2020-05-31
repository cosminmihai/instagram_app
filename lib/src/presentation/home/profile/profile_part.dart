import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:instagram_app/src/actions/actions.dart';
import 'package:instagram_app/src/actions/auth/logout.dart';
import 'package:instagram_app/src/containers/current_user_posts_count_container.dart';
import 'package:instagram_app/src/containers/user_container.dart';
import 'package:instagram_app/src/models/app_state.dart';
import 'package:instagram_app/src/models/auth/app_user.dart';

class ProfilePart extends StatelessWidget {
  const ProfilePart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UserContainer(builder: (BuildContext context, AppUser user) {
      return Column(
        children: <Widget>[
          AppBar(
            title: Text(user.username),
            actions: <Widget>[
              IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    StoreProvider.of<AppState>(context).dispatch(LogOut());
                  }),
            ],
          ),
          Flexible(
            child: ListView(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          ClipOval(
                            child: Container(
                              width: 96.0,
                              height: 96.0,
                              decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                              child: user.photoUrl == null
                                  ? const Icon(
                                      Icons.person,
                                      size: 64.0,
                                    )
                                  : Image.network(
                                      user.photoUrl,
                                      width: 96.0,
                                      height: 96.0,
                                    ),
                            ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Text(
                            user.displayName,
                            style: Theme.of(context).textTheme.bodyText1.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                          ),
                        ],
                      ),
                      CurrentUserPostsCountContainer(
                        builder: (BuildContext context, int posts) {
                          return ProfileInfo(
                            value: posts,
                            name: 'Posts',
                            onTap: () {},
                          );
                        },
                      ),
                      ProfileInfo(
                        name: 'Follower',
                        value: -1,
                        onTap: () {},
                      ),
                      ProfileInfo(
                        name: 'Following',
                        value: user.following.length,
                        onTap: () {
                          Navigator.pushNamed(context, '/usersList');
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      );
    });
  }
}

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    Key key,
    @required this.value,
    @required this.name,
    @required this.onTap,
  }) : super(key: key);

  final int value;
  final String name;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text('$value'),
            Text('$name'),
          ],
        ),
      ),
    );
  }
}
