import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/services/firebase/i_collection.dart';
import 'package:education_app/src/auth/data/models/local_user_model.dart';

class UserCollection implements ICollection<LocalUserModel> {
  final FirebaseFirestore instance;

  UserCollection({required this.instance});

  // final collection = FirebaseFirestore.instance
  //   .collection('users')
  //   .withConverter<LocalUserModel>(
  //     fromFirestore: (snapUser, options) {
  //       return LocalUserModel.fromMap(snapUser.data()!, uid: snapUser.id);
  //     },
  //     toFirestore: (value, options) => value.toInsertMap(),
  //   );

  @override
  Future<void> create(LocalUserModel value, {String? id}) async {
    await instance.collection('users').doc(id).set(value.toInsertMap());
  }

  @override
  Future<void> delete(String id) => throw UnimplementedError();

  @override
  Future<List<LocalUserModel>> getAll() => throw UnimplementedError();

  @override
  Future<LocalUserModel?> getById(String id) async {
    var snapUser = await instance.collection('users').doc(id).get();
    if (!snapUser.exists) return null;

    var user = LocalUserModel.fromMap(snapUser.data()!);
    return user;
  }

  @override
  Future<void> update(LocalUserModel value) async {
    await instance
        .collection('users')
        .doc(value.uid)
        .set(value.toMap(), SetOptions(merge: true));
  }
}
