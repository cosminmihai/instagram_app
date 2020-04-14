import 'package:flutter/material.dart';
import '../main.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailForgot = TextEditingController();
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
                'Recover your password',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32.0,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              alignment: AlignmentDirectional.center,
              child: const Text(
                'Enter your email adress assosiated with your Instagram account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16.0,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              keyboardType: TextInputType.emailAddress,
              controller: emailForgot,
              decoration: const InputDecoration(
                hintText: 'Email address',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            RaisedButton(
              elevation: 0,
              color: Colors.blue,
              onPressed: () async {
                if (emailForgot != null) {
                  await auth.sendEmailPasswordRecovery(emailForgot.text.trim());
                  await showDialog<void>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Email sent'),
                      content: const Text(
                          'An email was send to the mail address that you entered.'),
                      actions: <Widget>[
                        Container(
                          alignment: AlignmentDirectional.center,
                          child: OutlineButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, 'loginpage');
                            },
                            child: const Text('Great!'),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: const Text('Send email'),
            ),
          ],
        ),
      ),
    );
  }
}
