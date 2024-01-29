import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/core/common/entities/user.dart';
import 'package:demo/core/common/models/user_model.dart';
import 'package:demo/core/errors/firebase_failure.dart';
import 'package:demo/core/services/firebase/user_collection.dart';
import 'package:demo/core/utils/status_code.dart';
import 'package:firebase_auth/firebase_auth.dart' as f_auth;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class RegisterDatasource {
  Future<UserModel> registerUser({required User user});
  Future<UserModel> registerUserByEmail({
    required User user,
    required String email,
    required String password,
  });
}

class RegisterDatasourceImpl implements RegisterDatasource {
  RegisterDatasourceImpl({
    required this.firebaseAuth,
    required this.firestoreClient,
    required this.firebaseMessaging,
    required this.googleSignIn,
  }) {
    userCollection = UserCollection(instance: firestoreClient);
  }

  final f_auth.FirebaseAuth firebaseAuth;
  final FirebaseMessaging firebaseMessaging;
  final FirebaseFirestore firestoreClient;
  final GoogleSignIn googleSignIn;
  late UserCollection userCollection;

  @override
  Future<UserModel> registerUser({required User user}) async {
    try {
      final fcmToken = await firebaseMessaging.getToken();
      final sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setBool('isTokenSent', true);

      user as UserModel;

      final userToSave = user.copyWith(fcmToken: fcmToken);

      await userCollection.create(userToSave, id: userToSave.id);

      return Future.value(userToSave);
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
  Future<UserModel> registerUserByEmail({
    required User user,
    required String email,
    required String password,
  }) async {
    try {
      f_auth.User? firebaseUser;

      try {
        final result = await firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        firebaseUser = result.user;
      } catch (e) {
        final result = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        firebaseUser = result.user;
      }

      if (firebaseUser == null) {
        throw const FirebaseFailure(
          statusCode: StatusCode.firebaseAuthFailure,
        );
      }
      user as UserModel;

      final userToInsert = user.copyWith(
        firebaseIds: List.filled(1, firebaseUser.uid),
      );
      var userSaved = user;

      try {
        userSaved = await registerUser(user: userToInsert);
      } catch (e) {
        await userCollection.delete(firebaseUser.uid);
        throw FirebaseFailure(
          message: e.toString(),
          statusCode: StatusCode.deleteUser,
        );
      }

      return userSaved;
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
}
