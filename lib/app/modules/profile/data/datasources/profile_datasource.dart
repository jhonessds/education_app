import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/core/common/entities/user.dart';
import 'package:demo/core/common/models/user_model.dart';
import 'package:demo/core/errors/firebase_failure.dart';
import 'package:demo/core/services/firebase/user_collection.dart';
import 'package:demo/core/utils/status_code.dart';
import 'package:firebase_auth/firebase_auth.dart' as f_auth;
import 'package:firebase_storage/firebase_storage.dart';

abstract class ProfileDataSource {
  Future<UserModel> updateUser({required User user});
  Future<bool> deleteUser({required String userId});
  Future<UserModel> saveProfilePicture({required File profilePicture});
}

class ProfileDataSourceImpl implements ProfileDataSource {
  ProfileDataSourceImpl({
    required this.firestoreClient,
    required this.firebaseAuth,
    required this.storageClient,
  }) {
    userCollection = UserCollection(instance: firestoreClient);
  }

  final FirebaseStorage storageClient;
  final f_auth.FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestoreClient;
  late UserCollection userCollection;

  @override
  Future<UserModel> updateUser({required User user}) async {
    try {
      await userCollection.update(user as UserModel);
      return Future.value(user);
    } on FirebaseFailure {
      rethrow;
    } on FirebaseException catch (e) {
      throw FirebaseFailure(
        message: e.message ?? 'Unknow Error',
        statusCode: StatusCode.fromFirebase(e.code),
      );
    } catch (e) {
      throw FirebaseFailure(
        message: e.toString(),
        statusCode: StatusCode.problemWithRequest,
      );
    }
  }

  @override
  Future<UserModel> saveProfilePicture({required File profilePicture}) async {
    try {
      final userData = await userCollection.getById(
        firebaseAuth.currentUser!.uid,
      );

      if (userData == null) {
        throw const FirebaseFailure(statusCode: StatusCode.userNotFound);
      }

      final ext = profilePicture.path.split('.').last;
      final ref = storageClient
          .ref()
          .child('profilePictures/${firebaseAuth.currentUser?.uid}.$ext');
      await ref.putFile(profilePicture);
      final url = await ref.getDownloadURL();
      final userToUpdate = userData.copyWith(profilePicture: url);
      await userCollection.update(userToUpdate);
      return userToUpdate;
    } on FirebaseFailure {
      rethrow;
    } on FirebaseException catch (e) {
      throw FirebaseFailure(
        message: e.message ?? 'Unknow Error',
        statusCode: StatusCode.fromFirebase(e.code),
      );
    } catch (e) {
      throw FirebaseFailure(
        message: e.toString(),
        statusCode: StatusCode.problemWithRequest,
      );
    }
  }

  @override
  Future<bool> deleteUser({required String userId}) {
    throw UnimplementedError();
  }
}
