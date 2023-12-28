import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/cache_failure.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/on_boarding/data/datasources/on_boarding_datasource.dart';
import 'package:education_app/src/on_boarding/domain/repos/on_boarding_repo.dart';

class OnBoardingRepoImpl implements OnBoardingRepo {
  const OnBoardingRepoImpl({required this.localDataSource});

  final OnBoardingLocalDataSource localDataSource;

  @override
  ResultFuture<void> cacheFirstTimer() async {
    try {
      await localDataSource.cacheFirstTimer();
      return const Right(null);
    } on CacheFailure catch (e) {
      return Left(e);
    }
  }

  @override
  ResultFuture<bool> checkIfUserIsFirstTimer() async {
    try {
      final result = await localDataSource.checkIfUserIsFirstTimer();
      return Right(result);
    } on CacheFailure catch (e) {
      return Left(e);
    }
  }
}
