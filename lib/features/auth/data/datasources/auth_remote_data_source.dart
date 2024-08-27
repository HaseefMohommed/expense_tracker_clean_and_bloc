import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expesne_tracker_app/core/exceptions/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:expesne_tracker_app/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<UserModel> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<UserModel> authWithGoogle();
  Future<UserModel> authWithApple();
  Future<void> resetPassword({
    required String email,
  });
  Future<void> signOut();
}

class AuthRemoteDataSourceImp implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final GoogleSignIn googleSignIn;

  AuthRemoteDataSourceImp({
    required this.firebaseAuth,
    required this.firebaseFirestore,
    required this.googleSignIn,
  });

  @override
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user == null) {
        throw FirebaseAuthException(code: 'user-not-found');
      }
      final userData = await firebaseFirestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      if (!userData.exists) {
        throw ServerException();
      }

      return UserModel(
        id: userCredential.user!.uid,
        name: userData.data()!['name'] ?? '',
        email: email,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthenticationException(code: e.code);
    }
  }

  @override
  Future<UserModel> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) {
        throw FirebaseAuthException(code: 'user-not-found');
      }

      final newUser = UserModel(
        id: userCredential.user!.uid,
        name: name,
        email: email,
      );

      await firebaseFirestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(newUser.toJson());

      return newUser;
    } on FirebaseAuthException catch (e) {
      throw AuthenticationException(code: e.code);
    }
  }

  @override
  Future<UserModel> authWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        throw AuthenticationException(code: 'google-sign-in-aborted');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await firebaseAuth.signInWithCredential(credential);
      if (userCredential.user == null) {
        throw FirebaseAuthException(code: 'user-not-found');
      }

      final userData = await firebaseFirestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      if (!userData.exists) {
        final newUser = UserModel(
          id: userCredential.user!.uid,
          name: userCredential.user!.displayName ?? '',
          email: userCredential.user!.email ?? '',
        );
        await firebaseFirestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(newUser.toJson());
        return newUser;
      }

      return UserModel(
        id: userCredential.user!.uid,
        name: userData.data()!['name'] ?? '',
        email: userCredential.user!.email ?? '',
      );
    } on FirebaseAuthException catch (e) {
      throw AuthenticationException(code: e.code);
    } catch (e) {
      throw AuthenticationException(code: 'unknown');
    }
  }

  @override
  Future<UserModel> authWithApple() async {
  try {
    // Get Apple ID credentials
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    // Create OAuth credential
    final oauthCredential = OAuthProvider('apple.com').credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );

    // Sign in with credential
    final userCredential = await firebaseAuth.signInWithCredential(oauthCredential);
    
    if (userCredential.user == null) {
      throw FirebaseAuthException(code: 'user-not-found');
    }

    // Check if user exists in Firestore
    final userData = await firebaseFirestore
        .collection('users')
        .doc(userCredential.user!.uid)
        .get();

    if (!userData.exists) {
      // New user: create account
      final newUser = UserModel(
        id: userCredential.user!.uid,
        name: '${appleCredential.givenName ?? ''} ${appleCredential.familyName ?? ''}'.trim(),
        email: appleCredential.email ?? userCredential.user!.email ?? '',
      );

      // Save new user to Firestore
      await firebaseFirestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(newUser.toJson());

      return newUser;
    } else {
      // Existing user: return user data
      return UserModel(
        id: userCredential.user!.uid,
        name: userData.data()!['name'] ?? '',
        email: userData.data()!['email'] ?? userCredential.user!.email ?? '',
      );
    }
  } on FirebaseAuthException catch (e) {
    throw AuthenticationException(code: e.code);
  } catch (e) {
    throw AuthenticationException(code: 'unknown');
  }
}

  @override
  Future<void> resetPassword({
    required String email,
  }) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw AuthenticationException(code: e.code);
    } catch (e) {
      throw AuthenticationException(code: 'unknown');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await Future.wait([
        firebaseAuth.signOut(),
        googleSignIn.signOut(),
      ]);
    } on FirebaseAuthException catch (e) {
      throw AuthenticationException(code: e.code);
    } catch (e) {
      throw AuthenticationException(code: 'unknown');
    }
  }
}