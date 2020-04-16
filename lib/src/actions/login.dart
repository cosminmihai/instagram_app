import 'package:instagram_app/src/models/app_user.dart';

class Login {
  const Login(this.email, this.password);

  final String email;
  final String password;
}

class LoginSuccessful {
  const LoginSuccessful(this.user);

  final AppUser user;
}

class LoginError {
  LoginError(this.error);

  final Object error;
}
