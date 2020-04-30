/*import 'package:instagram_app/src/models/app_user.dart';

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
*/

library login;

import 'package:built_value/built_value.dart';
import 'package:instagram_app/src/actions/actions.dart';
import 'package:instagram_app/src/models/app_user.dart';

part 'login.g.dart';

abstract class Login //
    implements
        Built<Login, LoginBuilder>,
        AppAction //
{
  factory Login(String email, String password) {
    return _$Login((LoginBuilder b) {
      b
        ..email = email
        ..password = password;
    });
  }

  Login._();

  String get email;

  String get password;
}

abstract class LoginSuccessful //
    implements
        Built<LoginSuccessful, LoginSuccessfulBuilder>,
        AppAction //
{
  factory LoginSuccessful(AppUser user) {
    return _$LoginSuccessful((LoginSuccessfulBuilder b) {
      b.user = user.toBuilder();
    });
  }

  LoginSuccessful._();

  AppUser get user;
}

abstract class LoginError //
    implements
        Built<LoginError, LoginErrorBuilder>,
        ErrorAction //
{
  factory LoginError(Object error) {
    return _$LoginError((LoginErrorBuilder b) => b.error = error);
  }

  LoginError._();

  @override
  Object get error;
}
