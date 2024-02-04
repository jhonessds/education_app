import 'package:demo/app/modules/auth/domain/repos/auth_repository.dart';
import 'package:demo/core/abstraction/usecase.dart';
import 'package:demo/core/utils/typedefs.dart';

class SetLanguageCode extends UsecaseWithParam<void, String> {
  SetLanguageCode({required this.repository});

  final AuthRepository repository;

  @override
  ResultFuture<void> call(String params) async => repository.setLanguageCode(
        languageCode: params,
      );
}
