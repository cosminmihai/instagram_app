import 'package:instagram_app/src/models/app_user.dart';

class Registration {
  Registration({this.userName, this.birthDate, this.email, this.password});

  final String userName;
  final String birthDate;
  final String email;
  final String password;
}

class RegistrationSuccessful {
  RegistrationSuccessful(this.user);

  final AppUser user;
}

class RegistrationError {
  RegistrationError(this.error);

  final Object error;
}
