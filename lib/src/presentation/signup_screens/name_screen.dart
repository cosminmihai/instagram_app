import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:instagram_app/src/actions/reserve_username.dart';
import 'package:instagram_app/src/actions/update_registration_info.dart';
import 'package:instagram_app/src/containers/registration_info_container.dart';
import 'package:instagram_app/src/models/app_state.dart';
import 'package:instagram_app/src/models/registration_info.dart';

class SignUpName extends StatefulWidget {
  const SignUpName({Key key, @required this.onNext}) : super(key: key);
  final VoidCallback onNext;

  @override
  _SignUpNameState createState() => _SignUpNameState();
}

class _SignUpNameState extends State<SignUpName> {
  final TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
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
            RegistrationInfoContainer(
              builder: (BuildContext context, RegistrationInfo info) {
                return TextFormField(
                  controller: name,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Name',
                  ),
                  onChanged: (String value) {
                    StoreProvider.of<AppState>(context)
                        .dispatch(UpdateRegistrationInfo(info.copyWith(displayName: value)));
                  },
                  validator: (String value) {
                    if (value.trim().length < 3) {
                      return 'Your name is too short';
                    } else {
                      return null;
                    }
                  },
                );
              },
            ),
            const SizedBox(height: 20.0),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              constraints: const BoxConstraints.expand(height: 48.0),
              child: RaisedButton(
                elevation: 0.0,
                onPressed: () {
                  if (Form.of(context).validate()) {
                    StoreProvider.of<AppState>(context).dispatch(ReserveUsername());
                    FocusScope.of(context).requestFocus(FocusNode());
                    widget.onNext();
                  }
                },
                child: const Text('Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
