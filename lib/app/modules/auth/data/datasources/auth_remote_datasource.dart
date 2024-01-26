import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/core/common/entities/user.dart';
import 'package:demo/core/common/enums/user_type.dart';
import 'package:demo/core/common/models/user_model.dart';
import 'package:demo/core/enums/update_user.dart';
import 'package:demo/core/errors/server_failure.dart';
import 'package:demo/core/services/firebase/user_collection.dart';
import 'package:demo/core/utils/status_code.dart';
import 'package:firebase_auth/firebase_auth.dart' as f_auth;
import 'package:firebase_storage/firebase_storage.dart';

abstract class AuthRemoteDataSource {
  const AuthRemoteDataSource();

  Future<void> forgotPassword({required String email});

  Future<UserModel> signIn({
    required String email,
    required String password,
  });

  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
  });

  Future<void> updateUser({
    required User user,
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

  final f_auth.FirebaseAuth authClient;
  final FirebaseStorage storageClient;
  final FirebaseFirestore firestoreClient;

  late UserCollection userCollection;

  @override
  Future<void> forgotPassword({required String email}) {
    throw UnimplementedError();
  }

  @override
  Future<String> saveProfilePicture({required File profilePicture}) {
    throw UnimplementedError();
  }

  @override
  Future<UserModel> signIn({
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
          statusCode: StatusCode.userNotFound,
        );
      }

      var userData = await userCollection.getById(user.uid);

      if (userData != null) return userData;

      await _createUser(user, email);

      userData = await userCollection.getById(user.uid);

      return userData!;
    } on ServerFailure {
      rethrow;
    } on f_auth.FirebaseAuthException catch (e) {
      throw ServerFailure(
        message: e.message ?? 'Unknow Error',
        statusCode: StatusCode.fromFirebase(e.code),
      );
    } catch (e) {
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
  }) {
    throw UnimplementedError();
  }

  @override
  Future<void> updatePassword({
    required String oldPassword,
    required String newPassword,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateUser({
    required User user,
    required UpdateUserAction action,
  }) {
    throw UnimplementedError();
  }

  // @override
  // Future<void> forgotPassword({required String email}) async {
  //   try {
  //     await authClient.sendPasswordResetEmail(email: email);
  //   } on f_auth.FirebaseAuthException catch (e) {
  //     throw ServerFailure(
  //       message: e.message ?? 'Unknow Error',
  //       statusCode: StatusCode.fromFirebase(e.code),
  //     );
  //   } catch (e, s) {
  //     debugPrintStack(stackTrace: s);
  //     throw ServerFailure(
  //       message: e.toString(),
  //       statusCode: StatusCode.unknown,
  //     );
  //   }
  // }

  // @override
  // Future<UserModel> signIn({
  //   required String email,
  //   required String password,
  // }) async {
  //   try {
  //     final result = await authClient.signInWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );

  //     final user = result.user;

  //     if (user == null) {
  //       throw const ServerFailure(
  //         message: 'Try again later',
  //         statusCode: StatusCode.userNotFound,
  //       );
  //     }

  //     var userData = await userCollection.getById(user.uid);

  //     if (userData != null) return userData;

  //     await _createUser(user, email);

  //     userData = await userCollection.getById(user.uid);

  //     return userData!;
  //   } on ServerFailure {
  //     rethrow;
  //   } on f_auth.FirebaseAuthException catch (e) {
  //     throw ServerFailure(
  //       message: e.message ?? 'Unknow Error',
  //       statusCode: StatusCode.fromFirebase(e.code),
  //     );
  //   } catch (e, s) {
  //     debugPrintStack(stackTrace: s);
  //     throw ServerFailure(
  //       message: e.toString(),
  //       statusCode: StatusCode.unknown,
  //     );
  //   }
  // }

  // @override
  // Future<void> signUp({
  //   required String email,
  //   required String password,
  //   required String fullName,
  // }) async {
  //   try {
  //     final userCredential = await authClient.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );

  //     if (userCredential.user == null) {
  //       throw const ServerFailure(
  //         message: 'Try again later',
  //         statusCode: StatusCode.userNotFound,
  //       );
  //     }

  //     await userCredential.user?.updateDisplayName(fullName);
  //     await userCredential.user?.updatePhotoURL(MediaRes.defaultAvatar);

  //     await _createUser(userCredential.user, email, fullName: fullName);
  //   } on ServerFailure {
  //     rethrow;
  //   } on FirebaseAuthException catch (e) {
  //     throw ServerFailure(
  //       message: e.message ?? 'Unknow Error',
  //       statusCode: StatusCode.fromFirebase(e.code),
  //     );
  //   } catch (e, s) {
  //     debugPrintStack(stackTrace: s);
  //     throw ServerFailure(
  //       message: e.toString(),
  //       statusCode: StatusCode.unknown,
  //     );
  //   }
  // }

  // @override
  // Future<void> updateUser({
  //   required User user,
  //   required UpdateUserAction action,
  // }) async {
  //   try {
  //     if (action == UpdateUserAction.email) {
  //       await authClient.currentUser?.updateEmail(user.email);
  //     }
  //     if (action == UpdateUserAction.displayName) {
  //       await authClient.currentUser?.updateDisplayName(user.fullName);
  //     }

  //     await userCollection.update(user as UserModel);
  //   } on ServerFailure {
  //     rethrow;
  //   } on FirebaseAuthException catch (e) {
  //     throw ServerFailure(
  //       message: e.message ?? 'Unknow Error',
  //       statusCode: StatusCode.fromFirebase(e.code),
  //     );
  //   } catch (e, s) {
  //     debugPrintStack(stackTrace: s);
  //     throw ServerFailure(
  //       message: e.toString(),
  //       statusCode: StatusCode.unknown,
  //     );
  //   }
  // }

  // @override
  // Future<String> saveProfilePicture({required File profilePicture}) async {
  //   try {
  //     final userData = await userCollection.getById(
  //       authClient.currentUser!.uid,
  //     );

  //     if (userData == null) {
  //       throw const ServerFailure(
  //         message: 'User not found',
  //         statusCode: StatusCode.userNotFound,
  //       );
  //     }
  //     final ext = profilePicture.path.split('.').last;
  //     final ref = storageClient
  //         .ref()
  //         .child('profile_pic/${authClient.currentUser?.uid}.$ext');
  //     await ref.putFile(profilePicture);
  //     final url = await ref.getDownloadURL();
  //     await authClient.currentUser?.updatePhotoURL(url);
  //     await userCollection.update(userData.copyWith(profilePicture: url));
  //     return url;
  //   } on ServerFailure {
  //     rethrow;
  //   } catch (e, s) {
  //     debugPrintStack(stackTrace: s);
  //     throw ServerFailure(
  //       message: e.toString(),
  //       statusCode: StatusCode.unknown,
  //     );
  //   }
  // }

  // @override
  // Future<void> updatePassword({
  //   required String newPassword,
  //   required String oldPassword,
  // }) async {
  //   try {
  //     if (authClient.currentUser?.email == null) {
  //       throw const ServerFailure(
  //         message: 'User does not exist',
  //         statusCode: StatusCode.userNotFound,
  //       );
  //     }
  //     final credential = EmailAuthProvider.credential(
  //       email: authClient.currentUser!.email!,
  //       password: oldPassword,
  //     );
  //     await authClient.currentUser?.reauthenticateWithCredential(credential);
  //     await authClient.currentUser?.updatePassword(newPassword);
  //   } on ServerFailure {
  //     rethrow;
  //   } on FirebaseAuthException catch (e) {
  //     throw ServerFailure(
  //       message: e.message ?? 'Unknow Error',
  //       statusCode: StatusCode.fromFirebase(e.code),
  //     );
  //   } catch (e, s) {
  //     debugPrintStack(stackTrace: s);
  //     throw ServerFailure(
  //       message: e.toString(),
  //       statusCode: StatusCode.unknown,
  //     );
  //   }
  // }

  Future<void> _createUser(
    f_auth.User user,
    String email, {
    String? name,
  }) async {
    final userToInsert = UserModel(
      id: user.uid,
      email: user.email ?? email,
      name: name ?? (user.displayName ?? ''),
      userType: UserType.common,
      profilePicture: user.photoURL ?? '',
      firebaseIds: List.filled(1, user.uid),
    );

    await userCollection.create(userToInsert, id: user.uid);
  }
}
