import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:instagram_app/src/actions/auth/search_users.dart';
import 'package:instagram_app/src/containers/users_search_result_container.dart';
import 'package:instagram_app/src/models/app_state.dart';
import 'package:instagram_app/src/models/auth/app_user.dart';

class SearchPart extends StatefulWidget {
  const SearchPart({Key key}) : super(key: key);

  @override
  _SearchPartState createState() => _SearchPartState();
}

class _SearchPartState extends State<SearchPart> {
  final TextEditingController _query = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Material(
              elevation: 6.0,
              color: Theme.of(context).bottomAppBarColor,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                child: TextField(
                  controller: _query,
                  decoration: const InputDecoration(

                    hintText: 'Username, email or name',
                    suffixIcon: Icon(Icons.search),
                  ),
                  onChanged: (String value) {
                    StoreProvider.of<AppState>(context).dispatch(SearchUsers(value));
                  },
                ),
              ),
            ),
            Flexible(
              child: UsersSearchResultContainer(
                builder: (BuildContext context, List<AppUser> users) {
                  if (users.isEmpty) {
                    return const Center(
                      child: Text('Enter a value to search.'),
                    );
                  }

                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (BuildContext context, int index) {
                      final AppUser user = users[index];
                      return ListTile(
                        title: Text(user.displayName),
                        subtitle: Text('@${user.username}\n ${user.email}'),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
