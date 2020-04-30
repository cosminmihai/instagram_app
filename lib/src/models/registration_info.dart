library registration_info;

import 'package:built_value/built_value.dart';

part 'registration_info.g.dart';

abstract class RegistrationInfo implements Built<RegistrationInfo, RegistrationInfoBuilder> {
  factory RegistrationInfo([void Function(RegistrationInfoBuilder b) updates]) = _$RegistrationInfo;

  RegistrationInfo._();

  @nullable
  String get email;

  @nullable
  String get phone;

  @nullable
  String get verificationId;

  @nullable
  String get smsCode;

  @nullable
  String get displayName;

  @nullable
  String get password;

  @nullable
  DateTime get birthDate;

  @nullable
  String get username;

  @nullable
  bool get savePassword;
}
