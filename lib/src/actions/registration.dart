library registration;

import 'package:built_value/built_value.dart';
import 'package:instagram_app/src/actions/actions.dart';
import 'package:instagram_app/src/actions/reset_password.dart';
import 'package:instagram_app/src/models/app_user.dart';

part 'registration.g.dart';

abstract class Registration //
    implements
        Built<Registration, RegistrationBuilder>,
        AppAction //
{
  factory Registration(ActionResult result) {
    return _$Registration((RegistrationBuilder b) {
      b.result = result;
    });
  }

  Registration._();

  ActionResult get result;
}

abstract class RegistrationSuccessful //
    implements
        Built<RegistrationSuccessful, RegistrationSuccessfulBuilder>,
        AppAction //
{
  factory RegistrationSuccessful(AppUser user) {
    return _$RegistrationSuccessful((RegistrationSuccessfulBuilder b) {
      b.user = user.toBuilder();
    });
  }

  RegistrationSuccessful._();

  AppUser get user;
}

abstract class RegistrationError //
    implements
        Built<RegistrationError, RegistrationErrorBuilder>,
        ErrorAction //
{
  factory RegistrationError(Object error) {
    return _$RegistrationError((RegistrationErrorBuilder b) => b.error = error);
  }

  RegistrationError._();

  @override
  Object get error;
}
