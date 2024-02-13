import 'package:demo/app/modules/currency/domain/entities/currency_history.dart';
import 'package:demo/core/errors/cache_failure.dart';

abstract class HistoryListState {}

class LoadingHistoryState extends HistoryListState {}

class FailureHistoryListState extends HistoryListState {
  FailureHistoryListState(this.failure);
  final CacheFailure failure;
}

class SuccessHistoryListState extends HistoryListState {
  SuccessHistoryListState(this.histories);
  final List<CurrencyHistory> histories;
}
