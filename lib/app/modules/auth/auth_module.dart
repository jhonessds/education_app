import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/app/modules/auth/data/datasources/auth_remote_datasource.dart';
import 'package:demo/app/modules/auth/data/repos/auth_repository_impl.dart';
import 'package:demo/app/modules/auth/domain/repos/auth_repository.dart';
import 'package:demo/app/modules/auth/domain/usecases/sign_in_with_email.dart';
import 'package:demo/app/modules/auth/presentation/controllers/auth_controller.dart';
import 'package:demo/app/modules/auth/presentation/views/sign_in_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i
      ..addLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(
          firebaseAuth: FirebaseAuth.instance,
          firestoreClient: FirebaseFirestore.instance,
          googleSignIn: GoogleSignIn(),
        ),
      )
      ..addLazySingleton<AuthRepository>(AuthRepositoryImpl.new)
      ..addLazySingleton<SignInWithEmail>(SignInWithEmail.new)
      ..addLazySingleton<AuthController>(AuthController.new);
    super.exportedBinds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (_) => const SignInView());
  }
}
