import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:instagram_app/src/actions/registration.dart';
import 'package:instagram_app/src/models/app_state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController birdDate = TextEditingController();

  void _onResult(dynamic action) {
    if (action is RegistrationSuccessful) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            const SizedBox(height: 40.0),
            Container(
              height: 90.0,
              child: Image.asset('res/logo.png'),
            ),
            const SizedBox(height: 32.0),
            Container(
              alignment: AlignmentDirectional.center,
              child: const Text(
                'Sign up to see photos and videos from your friends.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16.0,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              keyboardType: TextInputType.emailAddress,
              controller: email,
              decoration: const InputDecoration(
                hintText: 'Email address',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              keyboardType: TextInputType.text,
              controller: userName,
              decoration: const InputDecoration(
                hintText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              keyboardType: TextInputType.text,
              controller: birdDate,
              decoration: const InputDecoration(
                hintText: 'Birth date',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: password,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              elevation: 0,
              color: Colors.blue,
              onPressed: () async {
                if (email.text.isNotEmpty &&
                    password.text.isNotEmpty &&
                    birdDate.text.isEmpty &&
                    userName.text.isNotEmpty) {}
                StoreProvider.of<AppState>(context).dispatch(
                  Registration(
                    email: email.text,
                    birthDate: birdDate.text,
                    password: password.text,
                    userName: userName.text,
                    result: _onResult,
                  ),
                );
              },
              child: const Text('Sign Up'),
            ),
            const SizedBox(height: 20.0),
            Container(
              alignment: AlignmentDirectional.center,
              child: Text.rich(
                TextSpan(
                  text: 'By signing up, you agree to our ',
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Terms.',
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
