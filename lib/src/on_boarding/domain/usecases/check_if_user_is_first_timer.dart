import 'package:demo/core/usecases/usecase.dart';
import 'package:demo/core/utils/typedefs.dart';
import 'package:demo/src/on_boarding/domain/repos/on_boarding_repo.dart';

class CheckIfUserIsFirstTimer extends UsecaseWithoutParam<bool> {
  CheckIfUserIsFirstTimer({required this.repository});

  final OnBoardingRepo repository;

  @override
  ResultFuture<bool> call() async => repository.checkIfUserIsFirstTimer();
}
