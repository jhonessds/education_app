import 'package:education_app/core/usecases/usecase.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/on_boarding/domain/repos/on_boarding_repo.dart';

class CheckIfUserIsFirstTimer extends UsecaseWithoutParam<bool> {
  CheckIfUserIsFirstTimer({required this.repository});

  final OnBoardingRepo repository;

  @override
  ResultFuture<bool> call() async => repository.checkIfUserIsFirstTimer();
}
