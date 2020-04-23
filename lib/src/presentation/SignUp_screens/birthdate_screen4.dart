import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignUpBirthDate extends StatefulWidget {
  const SignUpBirthDate({Key key}) : super(key: key);

  @override
  _SignUpBirthDateState createState() => _SignUpBirthDateState();
}

class _SignUpBirthDateState extends State<SignUpBirthDate> {
  TextEditingController password = TextEditingController();
  IconData buttonPressed = Icons.check_box_outline_blank;
  DateTime birthDate = DateTime.now();
  List<String> mouth = <String>[
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: <Widget>[
            const SizedBox(height: 16),
            Container(
              height: 100.0,
              child: Image.asset('res/instagram_cake.png'),
            ),
            const SizedBox(height: 16),
            Container(
              alignment: AlignmentDirectional.center,
              child: const Text(
                'Add your date of birth',
                style: TextStyle(
                  fontSize: 26.0,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              alignment: AlignmentDirectional.center,
              child: const Text(
                'This won\'t be part of your public profile.\nWhy do I need to provide my date of birth?',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              alignment: AlignmentDirectional.center,
              height: 55.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey[850],
                boxShadow: <BoxShadow>[
                  BoxShadow(color: Colors.tealAccent[200], spreadRadius: 1),
                ],
              ),
              child: Text(
                '${birthDate.day} ${mouth[birthDate.month - 1]} ${birthDate.year}',
                style: const TextStyle(color: Colors.grey, fontSize: 20.0),
              ),
            ),
            const SizedBox(height: 20.0),
            const SizedBox(
              height: 20.0,
            ),
            const SizedBox(height: 55),
            Container(
              alignment: AlignmentDirectional.center,
              child: const Text(
                'Use your own date of birth, even if this account is for a business, a pet of something else.',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              elevation: 0,
              color: Colors.blue,
              onPressed: () async {
                if (birthDate.toString().isNotEmpty) {
                  await Navigator.pushNamed(context, 'signUpWelcome');
                }
              },
              child: const Text('Next'),
            ),
            const SizedBox(height: 16.0),
            Container(
              height: 200,
              child: CupertinoDatePicker(
                backgroundColor: Colors.grey[850],
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (DateTime date) {
                  setState(() {
                    birthDate = date;
                    print(birthDate);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
