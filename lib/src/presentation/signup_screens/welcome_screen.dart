import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:instagram_app/src/containers/user_container.dart';
import 'package:instagram_app/src/models/app_user.dart';

class SignUpWelcome extends StatefulWidget {
  const SignUpWelcome({Key key, @required this.onNext}) : super(key: key);
  final VoidCallback onNext;

  @override
  _SignUpWelcomeState createState() => _SignUpWelcomeState();
}

class _SignUpWelcomeState extends State<SignUpWelcome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: const EdgeInsets.all(20.0),
        children: <Widget>[
          const SizedBox(height: 26.0),
          UserContainer(
            builder: (BuildContext context, AppUser user) {
              return Text(
                'Welcome to Instagram, ${user?.username}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w300,
                ),
              );
            },
          ),
          const SizedBox(height: 26.0),
          Container(
            alignment: AlignmentDirectional.center,
            child: const Text(
              'Find people to follow and start sharing photos. You can change your username at any time.',
              style: TextStyle(fontSize: 16.0, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 20.0),
          const SizedBox(height: 20.0),
          const SizedBox(
            height: 20.0,
          ),
          RaisedButton(
            elevation: 0,
            color: Colors.blue,
            onPressed: () {
              FocusScope.of(context).requestFocus(FocusNode());
              widget.onNext();
            },
            child: const Text('Next'),
          ),
          const SizedBox(height: 20.0),
          const Divider(thickness: 1.0),
          const SizedBox(height: 20.0),
          Container(
            alignment: AlignmentDirectional.bottomCenter,
            child: Text.rich(
              TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: 'Change Username',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 310.0),
          Container(
            alignment: AlignmentDirectional.bottomEnd,
            child: const Text(
              'By signing up, you agree to our Terms. Learn how we collect, use and share your date in our Data Policy and how we use cookies and similar technology in out Cookies Policy.',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
