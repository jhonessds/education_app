import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/core/common/models/user_model.dart';
import 'package:demo/core/errors/firebase_failure.dart';
import 'package:demo/core/services/firebase/i_collection.dart';
import 'package:demo/core/utils/helpers/user_helper.dart';
import 'package:demo/core/utils/status_code.dart';

class UserCollection implements ICollection<UserModel> {
  UserCollection({required this.instance});

  final FirebaseFirestore instance;

  // final collection = FirebaseFirestore.instance
  //   .collection('users')
  //   .withConverter<LocalUserModel>(
  //     fromFirestore: (snapUser, options) {
  //       return LocalUserModel.fromMap(snapUser.data()!, uid: snapUser.id);
  //     },
  //     toFirestore: (value, options) => value.toInsertMap(),
  //   );

  Future<UserModel?> getCachedUser() async {
    final cachedUser = await UserHelper.getUser();
    return cachedUser;
  }

  Future<UserModel?> getByFirebaseId(String id) async {
    final query = await instance
        .collection('users')
        .where('firebaseIds', arrayContains: id)
        .get();
    if (query.docs.isEmpty) {
      return null;
    }

    final snapUser = query.docs.first;

    if (!snapUser.exists) {
      return null;
    }

    final user = UserModel.fromMap(snapUser.data());
    await UserHelper.setUser(user);
    return user;
  }

  @override
  Future<void> create(UserModel value, {String? id}) async {
    try {
      await instance.collection('users').doc(id).set(value.toMap());
    } catch (e) {
      throw FirebaseFailure(
        message: e.toString(),
        statusCode: StatusCode.createUser,
      );
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await instance.collection('users').doc(id).delete();
    } catch (e) {
      throw FirebaseFailure(
        message: e.toString(),
        statusCode: StatusCode.deleteUser,
      );
    }
  }

  @override
  Future<List<UserModel>> getAll() async {
    try {
      throw UnimplementedError();
    } catch (e) {
      throw FirebaseFailure(
        message: e.toString(),
        statusCode: StatusCode.getUser,
      );
    }
  }

  @override
  Future<UserModel?> getById(String id) async {
    try {
      final snapUser = await instance.collection('users').doc(id).get();
      if (!snapUser.exists) return null;

      final user = UserModel.fromMap(snapUser.data()!);
      return user;
    } catch (e) {
      throw FirebaseFailure(
        message: e.toString(),
        statusCode: StatusCode.getUser,
      );
    }
  }

  @override
  Future<void> update(UserModel value) async {
    try {
      await instance
          .collection('users')
          .doc(value.id)
          .set(value.toMap(), SetOptions(merge: true));
    } catch (e) {
      throw FirebaseFailure(
        message: e.toString(),
        statusCode: StatusCode.updateUser,
      );
    }
  }
}
