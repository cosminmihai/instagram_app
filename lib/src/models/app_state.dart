import 'package:instagram_app/src/models/registration_info.dart';
import 'app_user.dart';

class AppState {
  const AppState({this.user, this.info});

  final AppUser user;
  final RegistrationInfo info;

  AppState copyWith({
    AppUser user,
    RegistrationInfo info,
  }) {
    return AppState(
      user: user ?? this.user,
      info: info ?? this.info,
    );
  }

  @override
  String toString() => 'AppState{user: $user, info: $info}';
}
