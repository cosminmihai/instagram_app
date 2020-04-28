import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:instagram_app/src/actions/update_registration_info.dart';
import 'package:instagram_app/src/containers/registration_info_container.dart';
import 'package:instagram_app/src/models/app_state.dart';
import 'package:instagram_app/src/models/registration_info.dart';
import 'package:intl/intl.dart';

class SignUpBirthDate extends StatefulWidget {
  const SignUpBirthDate({Key key, @required this.onNext}) : super(key: key);
  final VoidCallback onNext;

  @override
  _SignUpBirthDateState createState() => _SignUpBirthDateState();
}

class _SignUpBirthDateState extends State<SignUpBirthDate> {
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: RegistrationInfoContainer(
        builder: (BuildContext context, RegistrationInfo info) {
          final DateTime birthDate = info.birthDate ?? DateTime.now();
          final int year = DateTime.now().difference(birthDate).inDays ~/ 365;
          final DateFormat format = DateFormat.yMMMMd();
          return Column(
            children: <Widget>[
              const Text(
                'Add your date of birth',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 24.0),
              Text.rich(
                TextSpan(
                  text: 'This won\'t be a part of your public profile.\n',
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Why do I need to provide my date of birth?',
                      style: TextStyle(
                        color: Colors.lightBlue.shade50,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          print('show docs');
                        },
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.white70,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 16.0),
              Container(
                constraints: const BoxConstraints.expand(height: 48.0),
                child: OutlineButton(
                  onPressed: () {},
                  borderSide: BorderSide(
                    color: Theme.of(context).accentColor,
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(format.format(birthDate)),
                        ),
                      ),
                      Text(
                        ' ${year}',
                        style: TextStyle(color: year <= 4 ? Colors.red : Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 4.0),
              Container(
                alignment: AlignmentDirectional.centerStart,
                child: const Text(
                  'Add your name so that friends can find you.',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.white70,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              const Spacer(),
              Container(
                alignment: AlignmentDirectional.centerStart,
                child: const Text(
                  'Use your own birth date, even if this account is for business a pet or something else.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.white70,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Container(
                constraints: const BoxConstraints.expand(height: 48.0),
                child: RaisedButton(
                  elevation: 0.0,
                  onPressed: () {
                    if (year > 4) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      widget.onNext();
                    }
                  },
                  child: const Text('Next'),
                ),
              ),
              const SizedBox(height: 16.0),
              Theme(
                data: Theme.of(context).copyWith(
                    cupertinoOverrideTheme:
                        CupertinoThemeData(textTheme: CupertinoTextThemeData(primaryColor: Colors.white))),
                child: Container(
                  height: MediaQuery.of(context).size.height * .20,
                  child: CupertinoDatePicker(
                    backgroundColor: Colors.transparent,
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: DateTime.now(),
                    maximumDate: DateTime.now(),
                    onDateTimeChanged: (DateTime value) {
                      StoreProvider.of<AppState>(context)
                          .dispatch(UpdateRegistrationInfo(info.copyWith(birthDate: value)));
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
