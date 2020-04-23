import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignUpName extends StatefulWidget {
  const SignUpName({Key key}) : super(key: key);

  @override
  _SignUpNameState createState() => _SignUpNameState();
}

class _SignUpNameState extends State<SignUpName> {
  TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: <Widget>[
            Container(
              alignment: AlignmentDirectional.center,
              child: const Text(
                'Add your name',
                style: TextStyle(
                  fontSize: 26.0,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              alignment: AlignmentDirectional.center,
              child: const Text(
                'Add your name so that friends can find you',
                style: TextStyle(fontSize: 16.0, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              keyboardType: TextInputType.text,
              controller: name,
              decoration: const InputDecoration(
                hintText: 'Enter your name',
                border: OutlineInputBorder(),
              ),
            ),
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
            const SizedBox(height: 400.0),
            const Divider(thickness: 1.0),
            const SizedBox(height: 20.0),
            Container(
              alignment: AlignmentDirectional.bottomCenter,
              child: Text.rich(
                TextSpan(
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
