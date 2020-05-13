import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:instagram_app/src/models/app_state.dart';
import 'package:instagram_app/src/models/posts/post.dart';
import 'package:redux/redux.dart';

class PostContainer extends StatelessWidget {
  const PostContainer({Key key, @required this.builder}) : super(key: key);

  final ViewModelBuilder<List<Post>> builder;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<Post>>(
      converter: (Store<AppState> store) => store.state.posts.posts.toList(),
      builder: builder,
    );
  }
}
