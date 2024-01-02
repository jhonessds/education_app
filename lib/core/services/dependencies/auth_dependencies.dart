part of 'injection_container_main.dart';

Future<void> _initAuth() async {
  // Feature --> Auth
  // Bussiness Logic
  sl
    ..registerFactory(
      () => AuthBloc(
        signIn: sl(),
        signUp: sl(),
        updateUser: sl(),
        forgotPassword: sl(),
        updatePassword: sl(),
        saveProfilePicture: sl(),
      ),
    )
    ..registerLazySingleton(() => SignIn(repository: sl()))
    ..registerLazySingleton(() => SignUp(repository: sl()))
    ..registerLazySingleton(() => UpdateUser(repository: sl()))
    ..registerLazySingleton(() => ForgotPassword(repository: sl()))
    ..registerLazySingleton(() => UpdatePassword(repository: sl()))
    ..registerLazySingleton(() => SaveProfilePicture(repository: sl()))
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(sl()),
    )
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        authClient: sl(),
        storageClient: sl(),
        firestoreClient: sl(),
      ),
    )
    ..registerLazySingleton(() => FirebaseAuth.instance)
    ..registerLazySingleton(() => FirebaseFirestore.instance)
    ..registerLazySingleton(() => FirebaseStorage.instance);
}
