import 'package:education_app/core/usecases/usecase.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/on_boarding/domain/repos/on_boarding_repo.dart';

class CacheFirstTimer extends UsecaseWithoutParam<void> {
  CacheFirstTimer({required this.repository});

  final OnBoardingRepo repository;

  @override
  ResultFuture<void> call() async => repository.cacheFirstTimer();
}
