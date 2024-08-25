import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expesne_tracker_app/core/exceptions/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
}

class AuthRemoteDataSourceImp implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  AuthRemoteDataSourceImp({
    required this.firebaseAuth,
    required this.firebaseFirestore,
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
}
