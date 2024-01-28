import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/app/modules/register/data/datasource/register_datasource.dart';
import 'package:demo/app/modules/register/data/repositories/register_repository_impl.dart';
import 'package:demo/app/modules/register/domain/repositories/register_repository.dart';
import 'package:demo/app/modules/register/domain/usecases/register_user.dart';
import 'package:demo/app/modules/register/domain/usecases/register_user_by_email.dart';
import 'package:demo/app/modules/register/presenter/controllers/register_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RegisterModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i
      ..addLazySingleton<RegisterDatasource>(
        () => RegisterDatasourceImpl(
          firebaseAuth: FirebaseAuth.instance,
          firestoreClient: FirebaseFirestore.instance,
          googleSignIn: GoogleSignIn(),
          firebaseMessaging: FirebaseMessaging.instance,
        ),
      )
      ..addLazySingleton<RegisterRepository>(RegisterRepositoryImpl.new)
      ..addLazySingleton<RegisterUser>(RegisterUser.new)
      ..addLazySingleton<RegisterUserByEmail>(RegisterUserByEmail.new)
      ..addLazySingleton<RegisterController>(RegisterController.new);
    super.exportedBinds(i);
  }
}
