library get_action;

import 'package:built_value/built_value.dart';
import 'package:instagram_app/src/actions/actions.dart';
import 'package:instagram_app/src/models/auth/app_user.dart';

part 'get_action.g.dart';

abstract class GetContact //
    implements
        Built<GetContact, GetContactBuilder>,
        AppAction //
{
  factory GetContact(String uid) {
    return _$GetContact((GetContactBuilder b) => b.uid = uid);
  }

  GetContact._();

  String get uid;
}

abstract class GetContactSuccessful //
    implements
        Built<GetContactSuccessful, GetContactSuccessfulBuilder>,
        AppAction //
{
  factory GetContactSuccessful(AppUser user) {
    return _$GetContactSuccessful((GetContactSuccessfulBuilder b) => b.user = user.toBuilder());
  }

  GetContactSuccessful._();

  AppUser get user;
}

abstract class GetContactError //
    implements
        Built<GetContactError, GetContactErrorBuilder>,
        ErrorAction //
{
  factory GetContactError(Object error) {
    return _$GetContactError((GetContactErrorBuilder b) => b.error = error);
  }

  GetContactError._();

  @override
  Object get error;
}
