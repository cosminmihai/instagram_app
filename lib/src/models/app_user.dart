import 'package:flutter/cupertino.dart';

class AppUser {
  AppUser({
    @required this.uid,
    @required this.displayName,
    @required this.username,
    @required this.email,
    @required this.birthDate,
    @required this.photoUrl,
  });

  final String uid;
  final String displayName;
  final String username;
  final String email;
  final String birthDate;
  final String photoUrl;

  AppUser copyWith({
    final String uid,
    final String displayName,
    final String username,
    final String email,
    final String birthDate,
    final String photoUrl,
  }) {
    return AppUser(
      uid: uid ?? this.uid,
      displayName: displayName ?? this.displayName,
      username: username ?? this.username,
      email: email ?? this.email,
      birthDate: birthDate ?? this.birthDate,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  @override
  String toString() {
    return 'AppUser{uid: $uid, displayName: $displayName, username: $username, email: $email, birthDate: $birthDate, photoUrl: $photoUrl}';
  }
}
