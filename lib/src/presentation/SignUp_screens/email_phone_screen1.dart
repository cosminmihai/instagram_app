import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:instagram_app/src/actions/registration.dart';
import 'package:instagram_app/src/models/app_state.dart';
import 'package:instagram_app/src/presentation/SignUp_screens/components/input_option.dart';

class SignUpEmailPhone extends StatefulWidget {
  const SignUpEmailPhone({Key key}) : super(key: key);

  @override
  _SignUpEmailPhoneState createState() => _SignUpEmailPhoneState();
}

enum Option {
  phone,
  email,
}

class _SignUpEmailPhoneState extends State<SignUpEmailPhone> {
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  Option optionSelected = Option.email;

  void _onResult(dynamic action) {
    if (action is RegistrationSuccessful) {
      //Navigator.pop(context);
    }
  }

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
                'Enter phone number or email address',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
            const SizedBox(height: 26.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: InputOption(
                    onPressed: () {
                      setState(() {
                        optionSelected = Option.phone;
                      });
                    },
                    text: 'Phone',
                    color: optionSelected == Option.phone ? Colors.white : Colors.grey,
                  ),
                ),
                const SizedBox(width: 5.0),
                Expanded(
                  child: InputOption(
                    onPressed: () {
                      setState(() {
                        optionSelected = Option.email;
                      });
                    },
                    text: 'Email',
                    color: optionSelected == Option.email ? Colors.white : Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            TextField(
              keyboardType: optionSelected == Option.phone ? TextInputType.phone : TextInputType.emailAddress,
              controller: optionSelected == Option.phone ? phone : email,
              decoration: InputDecoration(
                hintText: optionSelected == Option.phone ? 'Phone number' : 'Email address',
                border: const OutlineInputBorder(),
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
                if (email.text.isNotEmpty || phone.text.isNotEmpty) {
                  await Navigator.pushNamed(context, 'signUpName');
                  /*StoreProvider.of<AppState>(context).dispatch(
                    Registration(
                      userName: email.text,
                      birthDate: null,
                      email: null,
                      password: null,
                      result: null,
                    ),
                  );*/
                }
              },
              child: const Text('Next'),
            ),
            const SizedBox(height: 400.0),
            Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            const SizedBox(height: 16.0),
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
