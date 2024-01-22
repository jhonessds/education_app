import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/core/services/dependencies/injection_container_main.dart';
import 'package:demo/src/auth/data/models/local_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DashboardUtils {
  const DashboardUtils._();

  static Stream<LocalUserModel> get userDataStream => sl<FirebaseFirestore>()
      .collection('users')
      .doc(sl<FirebaseAuth>().currentUser!.uid)
      .snapshots()
      .map((event) => LocalUserModel.fromMap(event.data()!));
}
