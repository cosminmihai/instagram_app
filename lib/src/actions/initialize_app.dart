import 'package:instagram_app/src/models/app_user.dart';

class InitializeApp {}

class InitializeAppSuccessful {
  InitializeAppSuccessful(this.user);

  final AppUser user;
}

class InitializeAppError {
  InitializeAppError(this.error);

  final Object error;
}
