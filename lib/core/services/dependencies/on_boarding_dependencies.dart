part of 'injection_container_main.dart';

Future<void> _initOnBoarding() async {
  final prefs = await SharedPreferences.getInstance();

  // Feature --> OnBoarding
  // Bussiness Logic
  sl
    ..registerFactory(
      () => OnBoardingCubit(
        cacheFirstTimer: sl(),
        checkIfUserIsFirstTimer: sl(),
      ),
    )
    ..registerLazySingleton(() => CacheFirstTimer(repository: sl()))
    ..registerLazySingleton(() => CheckIfUserIsFirstTimer(repository: sl()))
    ..registerLazySingleton<OnBoardingRepo>(
      () => OnBoardingRepoImpl(localDataSource: sl()),
    )
    ..registerLazySingleton<OnBoardingLocalDataSource>(
      () => OnBoardingLocalDataSrcImpl(prefs: sl()),
    )
    ..registerLazySingleton(() => prefs);
}
