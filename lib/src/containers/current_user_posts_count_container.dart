import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:instagram_app/src/models/app_state.dart';
import 'package:instagram_app/src/models/posts/post.dart';
import 'package:redux/redux.dart';

class CurrentUserPostsCountContainer extends StatelessWidget {
  const CurrentUserPostsCountContainer({Key key, this.builder}) : super(key: key);

  final ViewModelBuilder<int> builder;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, int>(
      converter: (Store<AppState> store) {
        return store.state.posts.posts.values //
            .where((Post post) => post.uid == store.state.auth.user.uid)
            .length;
      },
      builder: builder,
    );
  }
}
