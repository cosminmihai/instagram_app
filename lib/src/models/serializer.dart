library serializer;

import 'package:built_value/serializer.dart';
import 'package:instagram_app/src/models/app_state.dart';
import 'package:instagram_app/src/models/app_user.dart';
import 'package:instagram_app/src/models/registration_info.dart';

part 'serializer.g.dart';

@SerializersFor(<Type>[
  AppState,
  AppUser,
  RegistrationInfo,
])
Serializers serializers = _$serializers;
