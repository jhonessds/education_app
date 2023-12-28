import 'package:education_app/src/on_boarding/data/datasources/on_boarding_datasource.dart';
import 'package:education_app/src/on_boarding/data/repos/on_boarding_repo_impl.dart';
import 'package:education_app/src/on_boarding/domain/repos/on_boarding_repo.dart';
import 'package:education_app/src/on_boarding/domain/usecases/cache_first_timer.dart';
import 'package:education_app/src/on_boarding/domain/usecases/check_if_user_is_first_timer.dart';
import 'package:education_app/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
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
