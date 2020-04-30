library app_user;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'app_user.g.dart';

abstract class AppUser implements Built<AppUser, AppUserBuilder> {
  factory AppUser([void Function(AppUserBuilder b) updates]) = _$AppUser;

  AppUser._();

  String get uid;

  @nullable
  String get displayName;

  @nullable
  String get username;

  @nullable
  String get email;

  @nullable
  String get phone;

  @nullable
  DateTime get birthDate;

  @nullable
  String get photoUrl;

  static Serializer<AppUser> get serializer => _$appUserSerializer;
}
