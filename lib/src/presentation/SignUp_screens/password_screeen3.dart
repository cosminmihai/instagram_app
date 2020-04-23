import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignUpPassword extends StatefulWidget {
  const SignUpPassword({Key key}) : super(key: key);

  @override
  _SignUpPasswordState createState() => _SignUpPasswordState();
}

class _SignUpPasswordState extends State<SignUpPassword> {
  TextEditingController password = TextEditingController();
  IconData buttonPressed = Icons.check_box_outline_blank;

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
                'Create a password',
                style: TextStyle(
                  fontSize: 26.0,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              alignment: AlignmentDirectional.center,
              child: const Text(
                'We\'ll remember the login info, so you won\'t need to enter it again.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              obscureText: true,
              keyboardType: TextInputType.text,
              controller: password,
              decoration: const InputDecoration(
                hintText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      setState(() {
                        buttonPressed == Icons.check_box_outline_blank
                            ? buttonPressed = Icons.check_box
                            : buttonPressed = Icons.check_box_outline_blank;
                      });
                    },
                    child: Icon(buttonPressed)),
                const Text(
                  ' Save Password',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              elevation: 0,
              color: Colors.blue,
              onPressed: () async {
                if (password.text.isNotEmpty) {
                  await Navigator.pushNamed(context, 'signUpBirthDate');
                }
              },
              child: const Text('Next'),
            ),
            const SizedBox(height: 380.0),
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
