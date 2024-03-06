import 'package:demo/app/modules/currency/presenter/components/history/history_appbar.dart';
import 'package:demo/app/modules/currency/presenter/components/history/history_list.dart';
import 'package:flutter/material.dart';

class CurrencyHistoryView extends StatelessWidget {
  const CurrencyHistoryView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: HistoryAppBar(),
      body: HistoryList(),
    );
  }
}
