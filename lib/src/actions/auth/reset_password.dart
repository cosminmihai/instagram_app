library reset_password;

import 'package:built_value/built_value.dart';

import 'package:instagram_app/src/actions/actions.dart';

part 'reset_password.g.dart';

abstract class ResetPassword //
    implements
        Built<ResetPassword, ResetPasswordBuilder>,
        AppAction //
{
  factory ResetPassword(String email, ActionResult actionResult) {
    return _$ResetPassword((ResetPasswordBuilder b) {
      b
        ..email = email
        ..result = actionResult;
    });
  }

  ResetPassword._();

  ActionResult get result;

  String get email;
}

abstract class ResetPasswordSuccessful //
    implements
        Built<ResetPasswordSuccessful, ResetPasswordSuccessfulBuilder>,
        AppAction //
{
  factory ResetPasswordSuccessful() {
    return _$ResetPasswordSuccessful();
  }

  ResetPasswordSuccessful._();
}

abstract class ResetPasswordError //
    implements
        Built<ResetPasswordError, ResetPasswordErrorBuilder>,
        ErrorAction //
{
  factory ResetPasswordError(Object error) {
    return _$ResetPasswordError((ResetPasswordErrorBuilder b) => b.error = error);
  }

  ResetPasswordError._();

  @override
  Object get error;
}

/*

class ResetPassword {
  ResetPassword(this.email, this.actionResult);

  final ActionResult actionResult;
  final String email;
}

class ResetPasswordSuccessful {}

class ResetPasswordError {
  const ResetPasswordError(this.error);

  final Object error;
}
*/
