import 'package:demo/app/modules/currency/domain/entities/currency_history.dart';
import 'package:demo/app/modules/currency/domain/repos/currency_repository.dart';
import 'package:demo/core/abstraction/usecase.dart';
import 'package:demo/core/utils/typedefs.dart';

class SaveHistory extends UsecaseWithParam<void, CurrencyHistory> {
  SaveHistory({required this.repository});

  final CurrencyRepository repository;

  @override
  ResultFuture<void> call(CurrencyHistory params) async =>
      repository.saveHistory(model: params);
}
