import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:instagram_app/src/actions/auth/registration.dart';
import 'package:instagram_app/src/containers/registration_info_container.dart';
import 'package:instagram_app/src/models/app_state.dart';
import 'package:instagram_app/src/models/auth/registration_info.dart';

class SignUpWelcome extends StatefulWidget {
  const SignUpWelcome({Key key, @required this.onNext}) : super(key: key);
  final VoidCallback onNext;

  @override
  _SignUpWelcomeState createState() => _SignUpWelcomeState();
}

class _SignUpWelcomeState extends State<SignUpWelcome> {
  void onResult(dynamic action) {
    if (action is RegistrationSuccessful) {
      Navigator.pop(context);
    } else {
      print(action);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 26.0),
          RegistrationInfoContainer(
            builder: (BuildContext context, RegistrationInfo info) {
              return Text(
                'Welcome to Instagram, ${info?.username}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 23.0,
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
          const SizedBox(height: 24.0),
          Container(
            width: MediaQuery.of(context).size.width,
            child: RaisedButton(
              elevation: 0,
              color: Colors.blue,
              onPressed: () {
                StoreProvider.of<AppState>(context).dispatch(
                  Registration(onResult),
                );
              },
              child: const Text('Next'),
            ),
          ),
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
