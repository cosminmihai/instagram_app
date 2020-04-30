import 'package:instagram_app/src/actions/reset_password.dart';
import 'package:instagram_app/src/models/app_user.dart';

class Registration {
  const Registration(this.result);

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
