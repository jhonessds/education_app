import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/enums/update_user.dart';
import 'package:education_app/src/auth/data/models/local_user_model.dart';
import 'package:education_app/src/auth/domain/entities/local_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final FirebaseAuth _authClient;
  final FirebaseFirestore _firestoreClient;
  final FirebaseStorage _storageClient;

  const AuthRemoteDataSourceImpl({
    required FirebaseAuth authClient,
    required FirebaseFirestore firestoreClient,
    required FirebaseStorage storageClient,
  })  : _authClient = authClient,
        _firestoreClient = firestoreClient,
        _storageClient = storageClient;

  @override
  Future<void> forgotPassword({required String email}) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<LocalUserModel> signIn(
      {required String email, required String password}) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<void> signUp(
      {required String email,
      required String password,
      required String fullName}) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

  @override
  Future<void> updateUser(
      {required LocalUser user, required UpdateUserAction action}) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
