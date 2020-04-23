import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignUpWelcome extends StatefulWidget {
  const SignUpWelcome({Key key}) : super(key: key);

  @override
  _SignUpWelcomeState createState() => _SignUpWelcomeState();
}

class _SignUpWelcomeState extends State<SignUpWelcome> {
  TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: <Widget>[
            const SizedBox(height: 26.0),
            Container(
              alignment: AlignmentDirectional.center,
              child: const Text(
                'Welcome to Instagram, Cosmin',
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
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
              onPressed: () async {
                if (name.text.isNotEmpty) {
                  await Navigator.pushNamed(context, 'signUpPassword');
                }
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
            const SizedBox(height: 32.0),
            Container(
              alignment: AlignmentDirectional.bottomCenter,
              child: Text.rich(
                TextSpan(
                  style: const TextStyle(color: Colors.grey),
                  text: 'Already have an account? ',
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Sign In',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
