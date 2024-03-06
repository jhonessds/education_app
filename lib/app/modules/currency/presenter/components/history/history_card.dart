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
    final text =
        history.isGroup ? history.groupName : history.currencies.first.code;
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(
        left: 15,
        right: 15,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        margin: const EdgeInsets.all(18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SimpleText(
              alignment: Alignment.centerLeft,
              text: '${history.currencyOrigin} to $text',
              fontWeight: FontWeight.bold,
              color: context.theme.primaryColor,
              fontSize: 20,
            ),
            SimpleText(
              mgTop: 10,
              mgBottom: 5,
              alignment: Alignment.centerLeft,
              text: 'Amount ${history.amount}',
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            const Divider(),
            HistoryRow(history: history),
          ],
        ),
      ),
    );
  }
}
