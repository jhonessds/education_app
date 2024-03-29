import 'package:asp/asp.dart';
import 'package:demo/app/modules/currency/domain/entities/currency_history.dart';
import 'package:demo/core/common/states/app_state.dart';
import 'package:demo/core/common/widgets/simple_text.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:timeago/timeago.dart' as timeago;

class HistoryRow extends StatefulWidget {
  const HistoryRow({
    required this.history,
    super.key,
  });

  final CurrencyHistory history;

  @override
  State<HistoryRow> createState() => _HistoryRowState();
}

class _HistoryRowState extends State<HistoryRow> {
  @override
  void initState() {
    super.initState();
    timeago.setLocaleMessages('pt', timeago.PtBrShortMessages());
    timeago.setLocaleMessages('es', timeago.EsShortMessages());
    timeago.setLocaleMessages('en', timeago.EnShortMessages());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.history.currencies.length,
          itemBuilder: (context, index) {
            final currency = widget.history.currencies[index];
            return SimpleText(
              text: '${currency.code} = ${currency.conversion}',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            );
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              IconlyLight.time_circle,
              color: context.theme.disabledColor,
              size: 12,
            ),
            RxBuilder(
              builder: (context) {
                return SimpleText(
                  mgLeft: 2,
                  text: timeago.format(
                    widget.history.date,
                    locale: appConfigState.value.language.locale.languageCode,
                  ),
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  color: context.theme.disabledColor,
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
