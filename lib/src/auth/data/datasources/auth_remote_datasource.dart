import 'dart:io';

import 'package:education_app/core/enums/update_user.dart';
import 'package:education_app/core/errors/server_failure.dart';
import 'package:education_app/core/firebase/user_collection.dart';
import 'package:education_app/core/res/media_res.dart';
import 'package:education_app/core/utils/status_code.dart';
import 'package:education_app/src/auth/data/models/local_user_model.dart';
import 'package:education_app/src/auth/domain/entities/local_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

abstract class AuthRemoteDataSource {
  const AuthRemoteDataSource();

  Future<void> forgotPassword({required String email});

  Future<LocalUserModel> signIn({
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
  final FirebaseAuth _authClient;

  final FirebaseStorage _storageClient;
  final UserCollection _userCollection;

  AuthRemoteDataSourceImpl({
    required FirebaseAuth authClient,
    required FirebaseStorage storageClient,
    required UserCollection userCollection,
  })  : _authClient = authClient,
        _storageClient = storageClient,
        _userCollection = userCollection;

  @override
  Future<void> forgotPassword({required String email}) async {
    try {
      await _authClient.sendPasswordResetEmail(email: email);
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
  Future<LocalUserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _authClient.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = result.user;

      if (user == null) {
        throw const ServerFailure(
          message: 'Try again later',
          statusCode: StatusCode.unknown,
        );
      }

      var userData = await _userCollection.getById(user.uid);

      if (userData != null) return userData;

      await _createUser(user, email);

      userData = await _userCollection.getById(user.uid);

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
      final userCredential = await _authClient.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) {
        throw const ServerFailure(
          message: 'Try again later',
          statusCode: StatusCode.unknown,
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
      switch (action) {
        case UpdateUserAction.email:
          await _authClient.currentUser?.updateEmail(user.email);
        case UpdateUserAction.displayName:
          await _authClient.currentUser?.updateDisplayName(user.fullName);
        default:
      }
      await _userCollection.update(user as LocalUserModel);
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
      var userData = await _userCollection.getById(
        _authClient.currentUser!.uid,
      );

      if (userData == null) {
        throw const ServerFailure(
          message: 'User not found',
          statusCode: StatusCode.notFound,
        );
      }
      final ext = profilePicture.path.split('.').last;
      final ref = _storageClient
          .ref()
          .child('profile_pic/${_authClient.currentUser?.uid}.$ext');
      await ref.putFile(profilePicture);
      final url = await ref.getDownloadURL();
      await _authClient.currentUser?.updatePhotoURL(url);
      await _userCollection.update(userData.copyWith(profilePicture: url));
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
      if (_authClient.currentUser?.email == null) {
        throw const ServerFailure(
          message: 'User does not exist',
          statusCode: StatusCode.firebase,
        );
      }
      var credential = EmailAuthProvider.credential(
        email: _authClient.currentUser!.email!,
        password: oldPassword,
      );
      await _authClient.currentUser?.reauthenticateWithCredential(credential);
      await _authClient.currentUser?.updatePassword(newPassword);
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

    await _userCollection.create(userToInsert, id: user.uid);
  }
}
