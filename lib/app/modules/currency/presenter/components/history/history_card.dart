import 'package:demo/app/modules/currency/domain/entities/currency_history.dart';
import 'package:demo/app/modules/currency/presenter/components/history/history_row.dart';
import 'package:demo/core/common/widgets/simple_text.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({
    required this.history,
    super.key,
  });

  final CurrencyHistory history;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(
        left: 15,
        right: 15,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.all(18),
            child: Column(
              children: [
                SimpleText(
                  alignment: Alignment.centerLeft,
                  text: '${history.origin} to ${history.destiny}',
                  fontWeight: FontWeight.bold,
                  color: context.theme.primaryColor,
                  fontSize: 20,
                ),
                const SimpleText(
                  mgTop: 10,
                  mgBottom: 5,
                  alignment: Alignment.centerLeft,
                  text: 'Amount',
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
                HistoryRow(history: history),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
