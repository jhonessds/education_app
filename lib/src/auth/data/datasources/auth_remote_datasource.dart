import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/core/enums/update_user.dart';
import 'package:demo/core/errors/server_failure.dart';
import 'package:demo/core/res/media_res.dart';
import 'package:demo/core/services/firebase/user_collection.dart';
import 'package:demo/core/utils/status_code.dart';
import 'package:demo/src/auth/data/models/local_user_model.dart';
import 'package:demo/src/auth/domain/entities/local_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

abstract class AuthRemoteDataSource {
  const AuthRemoteDataSource();

  Future<void> forgotPassword({required String email});

  Future<LocalUser> signIn({
    required String email,
    required String password,
  });

  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
  });

  Future<void> updateUser({
    required LocalUser user,
    required UpdateUserAction action,
  });

  Future<void> updatePassword({
    required String oldPassword,
    required String newPassword,
  });

  Future<String> saveProfilePicture({required File profilePicture});
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({
    required this.authClient,
    required this.storageClient,
    required this.firestoreClient,
  }) {
    userCollection = UserCollection(instance: firestoreClient);
  }

  final FirebaseAuth authClient;
  final FirebaseStorage storageClient;
  final FirebaseFirestore firestoreClient;
  late UserCollection userCollection;

  @override
  Future<void> forgotPassword({required String email}) async {
    try {
      await authClient.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw ServerFailure(
        message: e.message ?? 'Unknow Error',
        statusCode: StatusCode.fromFirebase(e.code),
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerFailure(
        message: e.toString(),
        statusCode: StatusCode.unknown,
      );
    }
  }

  @override
  Future<LocalUser> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await authClient.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = result.user;

      if (user == null) {
        throw const ServerFailure(
          message: 'Try again later',
          statusCode: StatusCode.notFound,
        );
      }

      var userData = await userCollection.getById(user.uid);

      if (userData != null) return userData;

      await _createUser(user, email);

      userData = await userCollection.getById(user.uid);

      return userData!;
    } on ServerFailure {
      rethrow;
    } on FirebaseAuthException catch (e) {
      throw ServerFailure(
        message: e.message ?? 'Unknow Error',
        statusCode: StatusCode.fromFirebase(e.code),
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerFailure(
        message: e.toString(),
        statusCode: StatusCode.unknown,
      );
    }
  }

  @override
  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      final userCredential = await authClient.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) {
        throw const ServerFailure(
          message: 'Try again later',
          statusCode: StatusCode.notFound,
        );
      }

      await userCredential.user?.updateDisplayName(fullName);
      await userCredential.user?.updatePhotoURL(MediaRes.defaultAvatar);

      await _createUser(userCredential.user, email);
    } on ServerFailure {
      rethrow;
    } on FirebaseAuthException catch (e) {
      throw ServerFailure(
        message: e.message ?? 'Unknow Error',
        statusCode: StatusCode.fromFirebase(e.code),
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerFailure(
        message: e.toString(),
        statusCode: StatusCode.unknown,
      );
    }
  }

  @override
  Future<void> updateUser({
    required LocalUser user,
    required UpdateUserAction action,
  }) async {
    try {
      if (action == UpdateUserAction.email) {
        await authClient.currentUser?.updateEmail(user.email);
      }
      if (action == UpdateUserAction.displayName) {
        await authClient.currentUser?.updateDisplayName(user.fullName);
      }

      await userCollection.update(user as LocalUserModel);
    } on ServerFailure {
      rethrow;
    } on FirebaseAuthException catch (e) {
      throw ServerFailure(
        message: e.message ?? 'Unknow Error',
        statusCode: StatusCode.fromFirebase(e.code),
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerFailure(
        message: e.toString(),
        statusCode: StatusCode.unknown,
      );
    }
  }

  @override
  Future<String> saveProfilePicture({required File profilePicture}) async {
    try {
      final userData = await userCollection.getById(
        authClient.currentUser!.uid,
      );

      if (userData == null) {
        throw const ServerFailure(
          message: 'User not found',
          statusCode: StatusCode.notFound,
        );
      }
      final ext = profilePicture.path.split('.').last;
      final ref = storageClient
          .ref()
          .child('profile_pic/${authClient.currentUser?.uid}.$ext');
      await ref.putFile(profilePicture);
      final url = await ref.getDownloadURL();
      await authClient.currentUser?.updatePhotoURL(url);
      await userCollection.update(userData.copyWith(profilePicture: url));
      return url;
    } on ServerFailure {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerFailure(
        message: e.toString(),
        statusCode: StatusCode.unknown,
      );
    }
  }

  @override
  Future<void> updatePassword({
    required String newPassword,
    required String oldPassword,
  }) async {
    try {
      if (authClient.currentUser?.email == null) {
        throw const ServerFailure(
          message: 'User does not exist',
          statusCode: StatusCode.notFound,
        );
      }
      final credential = EmailAuthProvider.credential(
        email: authClient.currentUser!.email!,
        password: oldPassword,
      );
      await authClient.currentUser?.reauthenticateWithCredential(credential);
      await authClient.currentUser?.updatePassword(newPassword);
    } on ServerFailure {
      rethrow;
    } on FirebaseAuthException catch (e) {
      throw ServerFailure(
        message: e.message ?? 'Unknow Error',
        statusCode: StatusCode.fromFirebase(e.code),
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerFailure(
        message: e.toString(),
        statusCode: StatusCode.unknown,
      );
    }
  }

  Future<void> _createUser(User? user, String email) async {
    final userToInsert = LocalUserModel(
      uid: user!.uid,
      email: user.email ?? email,
      fullName: user.displayName ?? '',
      profilePicture: user.photoURL ?? '',
    );

    await userCollection.create(userToInsert, id: user.uid);
  }
}
