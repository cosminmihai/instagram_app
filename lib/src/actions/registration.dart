import 'package:flutter/cupertino.dart';
import 'package:instagram_app/src/actions/reset_password.dart';
import 'package:instagram_app/src/models/app_user.dart';

class Registration {
  const Registration({
    @required this.userName,
    @required this.birthDate,
    @required this.email,
    @required this.password,
    @required this.result,
  });

  final String userName;
  final String birthDate;
  final String email;
  final String password;
  final ActionResult result;
}

class RegistrationSuccessful {
  RegistrationSuccessful(this.user);

  final AppUser user;
}

class RegistrationError {
  RegistrationError(this.error);

  final Object error;
}
