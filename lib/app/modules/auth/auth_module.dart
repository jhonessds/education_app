import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/app/modules/auth/data/datasources/auth_remote_datasource.dart';
import 'package:demo/app/modules/auth/data/repos/auth_repository_impl.dart';
import 'package:demo/app/modules/auth/domain/repos/auth_repository.dart';
import 'package:demo/app/modules/auth/domain/usecases/email_has_verified.dart';
import 'package:demo/app/modules/auth/domain/usecases/forgot_password.dart';
import 'package:demo/app/modules/auth/domain/usecases/get_session_user.dart';
import 'package:demo/app/modules/auth/domain/usecases/log_out.dart';
import 'package:demo/app/modules/auth/domain/usecases/send_email_verification.dart';
import 'package:demo/app/modules/auth/domain/usecases/set_language_code.dart';
import 'package:demo/app/modules/auth/domain/usecases/sign_in_anonymously.dart';
import 'package:demo/app/modules/auth/domain/usecases/sign_in_with_email.dart';
import 'package:demo/app/modules/auth/domain/usecases/sign_in_with_facebook.dart';
import 'package:demo/app/modules/auth/domain/usecases/sign_in_with_github.dart';
import 'package:demo/app/modules/auth/domain/usecases/sign_in_with_google.dart';
import 'package:demo/app/modules/auth/domain/usecases/update_password.dart';
import 'package:demo/app/modules/auth/presenter/controllers/auth_controller.dart';
import 'package:demo/app/modules/auth/presenter/controllers/session_controller.dart';
import 'package:demo/app/modules/auth/presenter/views/sign_in_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i
      ..addLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance)
      ..addLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance)
      ..addLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance)
      ..addLazySingleton<FirebaseMessaging>(() => FirebaseMessaging.instance)
      ..addLazySingleton<GoogleSignIn>(GoogleSignIn.new)
      ..addLazySingleton<AuthRemoteDataSource>(AuthRemoteDataSourceImpl.new)
      ..addLazySingleton<AuthRepository>(AuthRepositoryImpl.new)
      // Use Cases
      ..addLazySingleton<SignInWithEmail>(SignInWithEmail.new)
      ..addLazySingleton<SignInWithGoogle>(SignInWithGoogle.new)
      ..addLazySingleton<SignInWithGithub>(SignInWithGithub.new)
      ..addLazySingleton<SignInWithFacebook>(SignInWithFacebook.new)
      ..addLazySingleton<SignInAnonymously>(SignInAnonymously.new)
      ..addLazySingleton<ForgotPassword>(ForgotPassword.new)
      ..addLazySingleton<UpdatePassword>(UpdatePassword.new)
      ..addLazySingleton<EmailHasVerified>(EmailHasVerified.new)
      ..addLazySingleton<LogOut>(LogOut.new)
      ..addLazySingleton<SetLanguageCode>(SetLanguageCode.new)
      ..addLazySingleton<SendEmailVerification>(SendEmailVerification.new)
      ..addLazySingleton<GetSessionUser>(GetSessionUser.new)
      // Controllers
      ..addLazySingleton<AuthController>(AuthController.new)
      ..addLazySingleton<SessionController>(SessionController.new);
    super.exportedBinds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (_) => const SignInView());
  }
}
