import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:instagram_app/src/presentation/signup_screens/birthdate_screen.dart';
import 'package:instagram_app/src/presentation/signup_screens/email_phone_screen.dart';
import 'package:instagram_app/src/presentation/signup_screens/name_screen.dart';
import 'package:instagram_app/src/presentation/signup_screens/password_screeen.dart';
import 'package:instagram_app/src/presentation/signup_screens/welcome_screen.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final PageController controller = PageController();

  void nextPage() {
    controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Flexible(
              child: Form(
                child: PageView(
                  controller: controller,
                  physics: const NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    SignUpEmailPhone(onNext: nextPage),
                    SignUpName(
                      onNext: nextPage,
                    ),
                    SignUpPassword(
                      onNext: nextPage,
                    ),
                    SignUpBirthDate(
                      onNext: nextPage,
                    ),
                    SignUpWelcome(
                      onNext: nextPage,
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Text.rich(
                TextSpan(
                  text: 'Already have an account? ',
                  style: const TextStyle(
                    fontSize: 14.0,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Sign in',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pop(context);
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
