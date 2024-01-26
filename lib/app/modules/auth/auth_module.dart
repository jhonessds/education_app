import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/app/modules/auth/data/datasources/auth_remote_datasource.dart';
import 'package:demo/app/modules/auth/data/repos/auth_repository_impl.dart';
import 'package:demo/app/modules/auth/domain/repos/auth_repository.dart';
import 'package:demo/app/modules/auth/domain/usecases/sign_in.dart';
import 'package:demo/app/modules/auth/presentation/controllers/auth_controller.dart';
import 'package:demo/app/modules/auth/presentation/views/sign_in_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i
      ..add<FirebaseFirestore>((_) => FirebaseFirestore.instance)
      ..add<FirebaseStorage>((_) => FirebaseStorage.instance)
      ..add<FirebaseAuth>((_) => FirebaseAuth.instance)
      ..add<AuthRemoteDataSource>(AuthRemoteDataSourceImpl.new)
      ..add<AuthRepository>(AuthRepositoryImpl.new)
      ..add<SignIn>(SignIn.new)
      ..add<AuthController>(AuthController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (_) => const SignInView());
  }
}
