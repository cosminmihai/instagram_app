import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:instagram_app/src/actions/login.dart';
import 'package:instagram_app/src/models/app_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
              controller: email,
              decoration: const InputDecoration(
                hintText: 'Email address',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32.0),
            TextField(
              controller: password,
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
                if (email.text.isNotEmpty && password.text.isNotEmpty) {
                  StoreProvider.of<AppState>(context).dispatch(Login(email.text, password.text));
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
                          Navigator.pushNamed(context, 'signUpEmailPhone');
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
