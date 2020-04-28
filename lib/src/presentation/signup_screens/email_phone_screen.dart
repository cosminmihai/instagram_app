import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:instagram_app/src/actions/update_registration_info.dart';
import 'package:instagram_app/src/containers/registration_info_container.dart';
import 'package:instagram_app/src/models/app_state.dart';
import 'package:instagram_app/src/models/registration_info.dart';
import 'package:email_validator/email_validator.dart';

class SignUpEmailPhone extends StatefulWidget {
  const SignUpEmailPhone({Key key, @required this.onNext}) : super(key: key);

  final VoidCallback onNext;

  @override
  _SignUpEmailPhoneState createState() => _SignUpEmailPhoneState();
}

class _SignUpEmailPhoneState extends State<SignUpEmailPhone> with SingleTickerProviderStateMixin {
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this, initialIndex: 1) //
      ..addListener(() {
        setState(() {});
        FocusScope.of(context).requestFocus(FocusNode());
      });
  }

  @override
  Widget build(BuildContext context) {
    final bool isPhone = tabController.index == 0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          const Text(
            'Enter phone number or email address',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 24.0),
          TabBar(
            controller: tabController,
            indicatorColor: Colors.white,
            tabs: const <Tab>[
              Tab(
                child: Text(
                  'Phone',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: 0.0, color: Colors.white),
          const SizedBox(height: 24.0),
          RegistrationInfoContainer(
            builder: (BuildContext context, RegistrationInfo info) {
              return TextFormField(
                controller: isPhone ? phone : email,
                keyboardType: isPhone ? TextInputType.phone : TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: isPhone ? 'Phone' : 'Email',
                ),
                onChanged: (String value) {
                  if (isPhone) {
                    // todo: add phone registration
                  } else {
                    info ??= const RegistrationInfo();
                    StoreProvider.of<AppState>(context).dispatch(UpdateRegistrationInfo(info.copyWith(email: value)));
                  }
                },
                validator: (String value) {
                  if (isPhone) {
                    if (value.length < 10) {
                      return 'Your phone number is to sort.';
                    } else if (!value.startsWith('07')) {
                      return 'Phone number is not from Romania.';
                    } else if (value.length > 10) {
                      return 'Your number is to long.';
                    } else {
                      return null;
                    }
                  } else {
                    if (!EmailValidator.validate(value)) {
                      return 'Enter an valid email address';
                    } else {
                      return null;
                    }
                  }
                },
              );
            },
          ),
          const SizedBox(height: 24.0),
          Container(
            constraints: const BoxConstraints.expand(height: 48.0),
            child: RaisedButton(
              elevation: 0.0,
              onPressed: () {
                if (Form.of(context).validate()) {
                  FocusScope.of(context).requestFocus(FocusNode());
                  widget.onNext();
                }
              },
              child: const Text('Next'),
            ),
          ),
        ],
      ),
    );
  }
}
