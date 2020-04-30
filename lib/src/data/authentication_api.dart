import 'dart:async';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:instagram_app/src/models/app_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_app/src/models/registration_info.dart';

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

  /// Create new user with email and password
  Future<AppUser> register(RegistrationInfo info) async {
    AuthResult result;
    if (info.email != null) {
      result = await auth.createUserWithEmailAndPassword(email: info.email, password: info.password);
    } else {
      assert(info.phone != null);
      assert(info.verificationId != null);
      assert(info.smsCode != null);

      final AuthCredential credential =
          PhoneAuthProvider.getCredential(verificationId: info.verificationId, smsCode: info.smsCode);
      result = await auth.signInWithCredential(credential);
    }

    return _buildUser(result.user, info);
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
  Future<AppUser> _buildUser(FirebaseUser user, [RegistrationInfo info]) async {
    if (user == null) {
      return null;
    }
    final DocumentSnapshot snapshot = await firestore.document('users/${user.uid}').get();
    if (snapshot.exists) {
      return AppUser.fromJson(snapshot.data);
    }
    assert(info != null);
    final AppUser appUser = AppUser(
      uid: user.uid,
      displayName: user.displayName,
      username: info.username,
      email: user.email,
      birthDate: info.birthDate,
      phone: info.phone,
      photoUrl: user.photoUrl,
    );
    await firestore.document('users/${user.uid}').setData(appUser.json);
    return appUser;
  }

  Future<String> reserveUsername({@required String email, @required String displayName}) async {
    if (email != null) {
      final String username = email.split('@')[0];

      final QuerySnapshot snapshot = await firestore
          .collection('users') //
          .where('username', isEqualTo: username)
          .getDocuments();

      if (snapshot.documents.isEmpty) {
        return username;
      }
    }

    String username = displayName.split(' ').join('.').toLowerCase();
    final QuerySnapshot snapshot = await firestore
        .collection('users') //
        .where('username', isEqualTo: username)
        .getDocuments();

    if (snapshot.documents.isEmpty) {
      return username;
    }

    final Random random = Random();
    return username = '${email.split('@')[0]}${random.nextInt(1 << 32)}';
  }

  /// Send an SMS to the user and return the verificationId to be used for login
  Future<String> sendSms(String phone) async {
    final Completer<String> completer = Completer<String>();

    await auth.verifyPhoneNumber(
      phoneNumber: '+4$phone',
      timeout: Duration.zero,
      verificationCompleted: (_) {},
      codeAutoRetrievalTimeout: (_) {},
      codeSent: (String verificationId, [_]) {
        completer.complete(verificationId);
      },
      verificationFailed: (AuthException error) {
        completer.completeError(error);
      },
    );

    return completer.future;
  }
}
