import 'app_user.dart';

class AppState {
  const AppState({this.user});

  final AppUser user;

  AppState copyWith({AppUser user}) {
    return AppState(
      user: user ?? this.user,
    );
  }
}
