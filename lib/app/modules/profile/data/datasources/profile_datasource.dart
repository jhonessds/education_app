import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/core/common/entities/user.dart';
import 'package:demo/core/common/models/user_model.dart';
import 'package:demo/core/errors/firebase_failure.dart';
import 'package:demo/core/services/firebase/user_collection.dart';
import 'package:demo/core/utils/status_code.dart';

abstract class ProfileDataSource {
  Future<UserModel> updateUser({required User user});
  Future<bool> deleteUser({required String userId});
}

class ProfileDataSourceImpl implements ProfileDataSource {
  ProfileDataSourceImpl({
    required this.firestoreClient,
  }) {
    userCollection = UserCollection(instance: firestoreClient);
  }

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
  Future<bool> deleteUser({required String userId}) {
    throw UnimplementedError();
  }
}
