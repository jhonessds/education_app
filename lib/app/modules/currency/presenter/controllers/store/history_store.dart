import 'package:demo/app/modules/currency/domain/entities/currency_history.dart';
import 'package:demo/app/modules/currency/domain/usecases/get_all_history.dart.dart';
import 'package:demo/app/modules/currency/presenter/controllers/state/history_state.dart';
import 'package:demo/core/errors/cache_failure.dart';
import 'package:flutter/material.dart';

class HistoryListStore extends ValueNotifier<HistoryListState> {
  HistoryListStore(this._getAllHistory) : super(SuccessHistoryListState([]));
  final GetAllHistory _getAllHistory;

  List<CurrencyHistory> mainList = <CurrencyHistory>[];

  Future<void> getAllHistory() async {
    value = LoadingHistoryState();
    final result = await _getAllHistory();

    await result.fold(
      (l) {
        value = FailureHistoryListState(l as CacheFailure);
      },
      (r) async {
        mainList.clear();
        mainList = r;
        mainList.sort((a, b) => a.date.compareTo(b.date));
        value = SuccessHistoryListState(mainList);
      },
    );
  }
}
