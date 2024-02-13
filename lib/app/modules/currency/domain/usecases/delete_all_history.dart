import 'package:demo/app/modules/currency/domain/repos/currency_repository.dart';
import 'package:demo/core/abstraction/usecase.dart';
import 'package:demo/core/utils/typedefs.dart';

class DeleteAllHistory extends UsecaseWithoutParam<void> {
  DeleteAllHistory({required this.repository});

  final CurrencyRepository repository;

  @override
  ResultFuture<void> call() async => repository.deleteAllHistory();
}
