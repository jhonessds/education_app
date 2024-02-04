import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/core/common/enums/auth_method_type.dart';
import 'package:demo/core/common/enums/gender_type.dart';
import 'package:demo/core/common/enums/user_type.dart';
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
  Future<void> updatePassword({
    required String oldPassword,
    required String newPassword,
  });
  Future<void> forgotPassword({required String email});
  Future<UserModel> signInWithEmail({
    required String email,
    required String password,
  });
  Future<UserModel> signInWithGoogle();
  Future<UserModel> signInWithGithub();
  Future<UserModel> signInWithFacebook();
  Future<UserModel> signInWithApple();
  Future<UserModel> signInAnonymously();
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
      User? firebaseUser;

      try {
        final result = await firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        firebaseUser = result.user;
      } catch (_) {
        throw const FirebaseFailure(
          statusCode: StatusCode.userNotFound,
        );
      }

      if (firebaseUser == null) {
        throw const FirebaseFailure(
          statusCode: StatusCode.firebaseAuthFailure,
        );
      }

      return await _getUser(firebaseUser);
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

      final fireUser =
          (await firebaseAuth.signInWithCredential(credential)).user;

      return await _getUser(fireUser);
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
  Future<UserModel> signInWithGithub() async {
    try {
      // referencia: https://www.youtube.com/watch?v=xvma6IFL21s
      final provider = GithubAuthProvider();
      final fireUser = (await firebaseAuth.signInWithProvider(provider)).user;
      return await _getUser(fireUser);
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
  Future<UserModel> signInWithFacebook() async {
    try {
      // referencia: https://www.youtube.com/watch?v=yjeocwN-Cqo&list=PLKKf8l1ne4_i3GK9zPYfCCXTdqRnGeSKN&index=6
      final provider = FacebookAuthProvider();
      final fireUser = (await firebaseAuth.signInWithProvider(provider)).user;
      return await _getUser(fireUser);
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
  Future<UserModel> signInWithApple() async {
    try {
      final provider = AppleAuthProvider();
      final fireUser = (await firebaseAuth.signInWithProvider(provider)).user;
      return await _getUser(fireUser);
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
  Future<UserModel> signInAnonymously() async {
    try {
      await firebaseAuth.signInAnonymously();

      final firebaseUser = firebaseAuth.currentUser;
      if (firebaseUser == null) {
        throw const FirebaseFailure(
          statusCode: StatusCode.firebaseAuthFailure,
        );
      }

      return UserModel(
        id: firebaseUser.uid,
        name: UserType.anonymous.translated,
        email: '',
        profilePicture: '',
        authMethod: AuthMethodType.anonymous,
        userType: UserType.anonymous,
      );
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

  Future<UserModel> _getUser(User? fireUser) async {
    try {
      if (fireUser == null) {
        throw const FirebaseFailure(
          statusCode: StatusCode.firebaseAuthFailure,
        );
      }

      final user = await userCollection.getById(fireUser.uid);

      if (user == null) {
        throw const FirebaseFailure(
          statusCode: StatusCode.userNotFound,
        );
      }

      return user;
    } on FirebaseFailure {
      rethrow;
    }
  }

  @override
  Future<void> updatePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final credential = EmailAuthProvider.credential(
        email: firebaseAuth.currentUser!.email!,
        password: oldPassword,
      );
      await firebaseAuth.currentUser?.reauthenticateWithCredential(credential);
      await firebaseAuth.currentUser?.updatePassword(newPassword);
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
}
