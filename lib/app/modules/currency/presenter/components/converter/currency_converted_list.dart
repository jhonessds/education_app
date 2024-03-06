import 'package:demo/app/modules/currency/presenter/controllers/state/currency_state.dart';
import 'package:demo/app/modules/currency/presenter/controllers/store/currency_store.dart';
import 'package:demo/core/common/widgets/simple_text.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:demo/core/utils/currency_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CurrencyConvertedList extends StatelessWidget {
  const CurrencyConvertedList({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Modular.get<CurrencyListStore>();

    return ValueListenableBuilder<CurrencyListState>(
      valueListenable: store,
      builder: (context, value, child) {
        return Container(
          margin: EdgeInsets.only(
            top: context.height * 0.4,
            bottom: 20,
            left: 15,
            right: 15,
          ),
          child: ListView.separated(
            padding: EdgeInsets.zero,
            separatorBuilder: (context, index) => const Divider(
              thickness: 1,
              height: 5,
            ),
            itemCount: store.group.currencies.length,
            itemBuilder: (context, index) {
              final currency = store.group.currencies[index];
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Text(
                  CurrencyUtils.currencyToEmoji(currency.code),
                  style: const TextStyle(
                    fontSize: 35,
                  ),
                ),
                title: SimpleText(
                  text: currency.code,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                trailing: SimpleText(
                  text: currency.conversion,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
