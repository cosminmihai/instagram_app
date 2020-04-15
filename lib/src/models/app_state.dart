import 'app_user.dart';

class AppState {
  AppState({this.user});

  final AppUser user;

  AppState copyWith({AppState user}) {
    return AppState(
      user: user ?? this.user,
    );
  }
}
