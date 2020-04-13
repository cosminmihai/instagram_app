import 'package:firebase_auth/firebase_auth.dart';

class AuthApi {
  const AuthApi({this.auth});

  final FirebaseAuth auth;

  /// Returns the current login in user or null if there is no user logged in.
  Future<FirebaseUser> getUser() async {
    final FirebaseUser user = await auth.currentUser();
    return user;
  }

  /// Tries to log the user in using his email and password.
  Future<FirebaseUser> login(String email, String password) async {
    final AuthResult result = await auth.signInWithEmailAndPassword(
        email: email.trim(), password: password);
    return result.user;
  }

  /// Log the user out.
  Future<void> logOut() async {
    await auth.signOut();
  }
}
