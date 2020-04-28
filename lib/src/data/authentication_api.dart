import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:instagram_app/src/models/app_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthApi {
  const AuthApi({@required this.auth, @required this.firestore});

  final Firestore firestore;
  final FirebaseAuth auth;

  /// Returns the current login in user or null if there is no user logged in.

  Future<AppUser> getUser() async {
    final FirebaseUser user = await auth.currentUser();
    return _buildUser(user);
  }

  /// Tries to log the user in using his email and password.

  Future<AppUser> login(String email, String password) async {
    final AuthResult result = await auth.signInWithEmailAndPassword(email: email.trim(), password: password);
    return _buildUser(result.user);
  }

  Future<AppUser> register(String email, String password) async {
    final AuthResult result = await auth.createUserWithEmailAndPassword(email: email.trim(), password: password);
    return _buildUser(result.user);
  }

  /// Log the user out.

  Future<void> logOut() async {
    await auth.signOut();
  }

  ///Send the reset password link to the [email].

  Future<void> sendEmailPasswordRecovery(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  ///Create a Firebase user and store the data in Firestore.
  Future<AppUser> _buildUser(FirebaseUser user) async {
    if (user == null) {
      return null;
    }
    final DocumentSnapshot snapshot = await firestore.document('users/${user.uid}').get();
    if (snapshot.exists) {
      return AppUser.fromJson(snapshot.data);
    }

    final AppUser appUser = AppUser(
      uid: user.uid,
      displayName: user.displayName,
      username: null,
      email: user.email,
      birthDate: null,
      photoUrl: user.photoUrl,
    );
    await firestore.document('users/${user.uid}').setData(appUser.json);
    return appUser;
  }

  Future<String> reserveUsername({@required String email, @required String displayName}) async {
    String username = email.split('@')[0];
    QuerySnapshot snapshot = await firestore.collection('users').where('username', isEqualTo: username).getDocuments();
    if (snapshot.documents.isEmpty) {
      return username;
    }

    username = displayName.split(' ').join('.').toLowerCase();
    snapshot = await firestore.collection('users').where('username', isEqualTo: username).getDocuments();
    if (snapshot.documents.isEmpty) {
      return username;
    }
    final Random randomNumber = Random();
    return username = '${email.split('@')[0]}${randomNumber.nextInt(1 << 32)}';
  }
}
