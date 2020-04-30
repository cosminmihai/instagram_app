library app_state;

import 'package:built_value/built_value.dart';
import 'package:instagram_app/src/models/registration_info.dart';
import 'app_user.dart';

part 'app_state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  factory AppState([void Function(AppStateBuilder b) updates]) = _$AppState;

  AppState._();

  @nullable
  AppUser get user;

  @nullable
  RegistrationInfo get info;
}
