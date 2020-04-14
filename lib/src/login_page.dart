import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../main.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email1 = TextEditingController();
  TextEditingController password1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            const SizedBox(height: 72.0),
            Container(
              height: 90.0,
              child: Image.asset('res/logo.png'),
            ),
            const SizedBox(height: 32.0),
            TextField(
              keyboardType: TextInputType.emailAddress,
              controller: email1,
              decoration: const InputDecoration(
                hintText: 'Email address',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32.0),
            TextField(
              controller: password1,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            Container(
              alignment: AlignmentDirectional.centerEnd,
              child: FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'forgotPassword');
                  print('Forgot password');
                },
                child: Text(
                  'Forgot password?',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
            ),
            RaisedButton(
              elevation: 0,
              color: Colors.blue,
              onPressed: () async {
                final FirebaseUser user =
                    await auth.login(email1.text.trim(), password1.text);
                if (email1.text.isNotEmpty && password1.text.isNotEmpty) {
                  await Navigator.pushReplacementNamed(context, 'homepage');
                  print('Succesfuly logged in');
                }
              },
              child: const Text('Log in'),
            ),
            const SizedBox(height: 32.0),
            Container(
              alignment: AlignmentDirectional.center,
              child: Text.rich(
                TextSpan(
                  text: 'Don\'t have an account? ',
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Sign Up',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          print('Sign up.');
                        },
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              height: 16.0,
            ),
            const SizedBox(height: 16.0),
            Container(
              alignment: AlignmentDirectional.center,
              child: const Text('Instagram from Cosmin Big Boss'),
            )
          ],
        ),
      ),
    );
  }
}
