import 'dart:async';
import 'dart:math';
import 'package:built_collection/built_collection.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:instagram_app/src/models/auth/app_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_app/src/models/auth/registration_info.dart';
import 'package:algolia/algolia.dart';

class AuthApi {
  const AuthApi({
    @required FirebaseAuth auth,
    @required Firestore firestore,
    @required AlgoliaIndexReference index,
    @required CloudFunctions cloudFunctions,
  })  : assert(auth != null),
        assert(firestore != null),
        assert(index != null),
        assert(cloudFunctions != null),
        _auth = auth,
        _firestore = firestore,
        _index = index,
        _cloudFunctions = cloudFunctions;

  final Firestore _firestore;
  final FirebaseAuth _auth;
  final AlgoliaIndexReference _index;
  final CloudFunctions _cloudFunctions;

  /// Returns the current login in user or null if there is no user logged in.
  Future<AppUser> getUser() async {
    final FirebaseUser user = await _auth.currentUser();
    return _buildUser(user);
  }

  /// Tries to log the user in using his email and password.
  Future<AppUser> login(String email, String password) async {
    final AuthResult result = await _auth.signInWithEmailAndPassword(email: email.trim(), password: password);
    return _buildUser(result.user);
  }

  /// Create new user with email and password
  Future<AppUser> register(RegistrationInfo info) async {
    AuthResult result;
    if (info.email != null) {
      result = await _auth.createUserWithEmailAndPassword(email: info.email, password: info.password);
    } else {
      assert(info.phone != null);
      assert(info.verificationId != null);
      assert(info.smsCode != null);

      final AuthCredential credential =
          PhoneAuthProvider.getCredential(verificationId: info.verificationId, smsCode: info.smsCode);
      result = await _auth.signInWithCredential(credential);
    }

    return _buildUser(result.user, info);
  }

  /// Log the user out.
  Future<void> logOut() async {
    await _auth.signOut();
  }

  ///Send the reset password link to the [email].
  Future<void> sendEmailPasswordRecovery(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  ///Create a Firebase user and store the data in Firestore.
  Future<AppUser> _buildUser(FirebaseUser user, [RegistrationInfo info]) async {
    if (user == null) {
      return null;
    }
    final DocumentSnapshot snapshot = await _firestore.document('users/${user.uid}').get();
    if (snapshot.exists && info == null) {
      return AppUser.fromJson(snapshot.data);
    }
    assert(info != null);
    final AppUser appUser = AppUser((AppUserBuilder b) {
      b
        ..uid = user.uid
        ..displayName = info.displayName
        ..username = info.username
        ..email = info.email
        ..birthDate = info.birthDate
        ..phone = info.phone
        ..photoUrl = user.photoUrl
        ..following = ListBuilder<String>();
    });
    await _firestore.document('users/${user.uid}').setData(appUser.json);
    return appUser;
  }

  /// Create a username for user.
  Future<String> reserveUsername({@required String email, @required String displayName}) async {
    if (email != null) {
      final String username = email.split('@')[0];
      if (await _checkUsername(username) != null) {
        return username;
      }
    }
    String username = displayName.split(' ').join('.').toLowerCase();
    if (await _checkUsername(username) != null) {
      return username;
    }
    final Random random = Random();
    if (email != null) {
      username = '${email.split('@')[0]}${random.nextInt(1 << 32)}';
    } else {
      username = '${displayName.split(' ').join('.')}${random.nextInt(1 << 32)}';
    }
    return username;
  }

  /// Send an SMS to the user and return the verificationId to be used for login
  Future<String> sendSms(String phone) async {
    final Completer<String> completer = Completer<String>();

    await _auth.verifyPhoneNumber(
      phoneNumber: '+4$phone',
      timeout: const Duration(seconds: 60),
      verificationCompleted: (_) {
        print('Verification is complete');
      },
      codeAutoRetrievalTimeout: (_) {
        print('Time runs out');
      },
      codeSent: (String verificationId, [_]) {
        print('Code sent');
        completer.complete(verificationId);
      },
      verificationFailed: (AuthException authException) {
        print('VerificationFailed: ${authException.message}');
      },
    );

    return completer.future;
  }

  /// Provides all the users.
  Future<AppUser> getContacts(String uid) async {
    final DocumentSnapshot snapshot = await _firestore.document('users/$uid').get();
    return AppUser.fromJson(snapshot.data);
  }

  /// Search for users.
  Future<List<AppUser>> searchUsers({
    @required String query,
    @required String uid,
  }) async {
    final AlgoliaQuerySnapshot result = await _index.setFacetFilter('uid:-$uid').search(query).getObjects();
    if (result.empty) {
      return <AppUser>[];
    } else {
      return result.hits.map((AlgoliaObjectSnapshot object) => AppUser.fromJson(object.data)).toList();
    }
  }

  /// Follow a specific user.
  Future<void> startFollowing({
    @required String uid,
    @required String followingUid,
  }) async {
    await _firestore.document('users/$uid').updateData(<String, dynamic>{
      'following': FieldValue.arrayUnion(<String>[followingUid])
    });
  }

  /// Un-follow a specific user.
  Future<void> stopFollowing({
    @required String uid,
    @required String followingUid,
  }) async {
    await _firestore.document('users/$uid').updateData(<String, dynamic>{
      'following': FieldValue.arrayRemove(<String>[followingUid])
    });
  }

  /// Checks if username exists in firebase.
  Future<String> _checkUsername(String username) async {
    final HttpsCallable checkUsername = _cloudFunctions.getHttpsCallable(functionName: 'checkUsername');
    final HttpsCallableResult result = await checkUsername(<String, String>{'username': username});
    return result.data;
  }
}
