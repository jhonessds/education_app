import 'package:demo/app/modules/currency/domain/entities/currency_history.dart';
import 'package:demo/app/modules/currency/domain/repos/currency_repository.dart';
import 'package:demo/core/abstraction/usecase.dart';
import 'package:demo/core/utils/typedefs.dart';

class GetAllHistory extends UsecaseWithoutParam<List<CurrencyHistory>> {
  GetAllHistory({required this.repository});

  final CurrencyRepository repository;

  @override
  ResultFuture<List<CurrencyHistory>> call() async =>
      repository.getAllHistory();
}
