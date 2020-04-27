import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:instagram_app/src/actions/update_registration_info.dart';
import 'package:instagram_app/src/containers/registration_info_container.dart';
import 'package:instagram_app/src/models/app_state.dart';
import 'package:instagram_app/src/models/registration_info.dart';

class SignUpPassword extends StatefulWidget {
  const SignUpPassword({Key key, @required this.onNext}) : super(key: key);
  final VoidCallback onNext;

  @override
  _SignUpPasswordState createState() => _SignUpPasswordState();
}

class _SignUpPasswordState extends State<SignUpPassword> {
  TextEditingController password = TextEditingController();
  IconData buttonPressed = Icons.check_box_outline_blank;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: RegistrationInfoContainer(
        builder: (BuildContext context, RegistrationInfo info) {
          return Column(
            children: <Widget>[
              const Text(
                'Create a password',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 24.0),
              Container(
                padding: const EdgeInsetsDirectional.only(start: 16.0),
                child: const Text(
                  'We\'ll remember the login info, so you won\'t need to enter it on your iCloud® devices.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.white70,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Container(
                padding: const EdgeInsetsDirectional.only(start: 16.0),
                child: TextField(
                  controller: password,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Password',
                  ),
                  onChanged: (String value) {
                    StoreProvider.of<AppState>(context)
                        .dispatch(UpdateRegistrationInfo(info.copyWith(password: value)));
                  },
                ),
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                    value: info.savePassword,
                    onChanged: (bool value) {
                      StoreProvider.of<AppState>(context)
                          .dispatch(UpdateRegistrationInfo(info.copyWith(savePassword: value)));
                    },
                  ),
                  const Text('Save password'),
                ],
              ),
              const SizedBox(height: 8.0),
              Container(
                constraints: const BoxConstraints.expand(height: 48.0),
                padding: const EdgeInsetsDirectional.only(start: 16.0),
                child: RaisedButton(
                  elevation: 0.0,
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    widget.onNext();
                  },
                  child: const Text('Next'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
