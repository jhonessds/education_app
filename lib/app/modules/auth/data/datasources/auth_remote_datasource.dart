import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/core/common/models/user_model.dart';
import 'package:demo/core/errors/auth_failure.dart';
import 'package:demo/core/errors/firebase_failure.dart';
import 'package:demo/core/services/firebase/user_collection.dart';
import 'package:demo/core/utils/status_code.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthRemoteDataSource {
  const AuthRemoteDataSource();

  Future<UserModel?> getSessionUser();
  Future<void> logOut();
  Future<void> forgotPassword({required String email});
  Future<UserModel> signInWithEmail({
    required String email,
    required String password,
  });
  Future<UserModel> signInWithGoogle();
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firestoreClient,
    required this.googleSignIn,
  }) {
    userCollection = UserCollection(instance: firestoreClient);
  }

  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestoreClient;
  final GoogleSignIn googleSignIn;
  late UserCollection userCollection;

  @override
  Future<void> logOut() async {
    try {
      await googleSignIn.signOut();
      await firebaseAuth.signOut();
    } catch (e) {
      throw FirebaseFailure(
        message: e.toString(),
        statusCode: StatusCode.problemWithRequest,
      );
    }
  }

  @override
  Future<UserModel?> getSessionUser() async {
    try {
      final cachedUser = await userCollection.getCachedUser();
      if (cachedUser != null) return cachedUser;

      final firebaseUser = firebaseAuth.currentUser;
      if (firebaseUser == null) throw const UserNotAuthenticated();
      final user = await userCollection.getById(firebaseUser.uid);

      return user;
    } catch (e) {
      throw FirebaseFailure(
        message: e.toString(),
        statusCode: StatusCode.problemWithRequest,
      );
    }
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
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
  Future<UserModel> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final result = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.user == null) throw const FirebaseAuthFailure();

      final userData = await userCollection.getById(result.user!.uid);

      if (userData != null) throw const UserNotFound();

      return userData!;
    } on FirebaseFailure {
      rethrow;
    } on FirebaseAuthException catch (e) {
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
  Future<UserModel> signInWithGoogle() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) throw const GoogleAuthFailure();

      final googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final firebaseUser =
          (await firebaseAuth.signInWithCredential(credential)).user;
      if (firebaseUser == null) throw const FirebaseAuthFailure();

      final user = await userCollection.getById(firebaseUser.uid);

      if (user != null) throw const UserNotFound();

      return user!;
    } catch (e) {
      throw FirebaseFailure(
        message: e.toString(),
        statusCode: StatusCode.problemWithRequest,
      );
    }
  }
}
