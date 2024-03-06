import 'package:demo/app/modules/currency/presenter/components/history/history_card.dart';
import 'package:demo/app/modules/currency/presenter/controllers/state/history_state.dart';
import 'package:demo/app/modules/currency/presenter/controllers/store/history_store.dart';
import 'package:demo/core/common/widgets/empty_widget.dart';
import 'package:demo/core/common/widgets/global_error_widget.dart';
import 'package:demo/core/common/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HistoryList extends StatefulWidget {
  const HistoryList({
    super.key,
  });

  @override
  State<HistoryList> createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  final store = Modular.get<HistoryListStore>();

  @override
  void initState() {
    super.initState();
    store.getAllHistory();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<HistoryListState>(
      valueListenable: store,
      builder: (context, value, child) {
        if (value is LoadingHistoryState) {
          return const LoadingWidget(
            animationHeight: 200,
            withAnimation: true,
            svg: 'loading_clock',
          );
        } else if (value is FailureHistoryListState) {
          return GlobalErrorWidget(
            connectionError: value.failure.isConnectionError,
          );
        } else {
          value as SuccessHistoryListState;
          if (value.histories.isEmpty) {
            return const EmptyWidget(
              animationHeight: 200,
              message: 'No history',
            );
          }
          return ListView.separated(
            primary: true,
            separatorBuilder: (context, index) => const SizedBox(
              height: 25,
            ),
            padding: const EdgeInsets.symmetric(vertical: 20),
            itemCount: store.mainList.length,
            itemBuilder: (context, index) {
              final history = store.mainList[index];
              return HistoryCard(history: history);
            },
          );
        }
      },
    );
  }
}
