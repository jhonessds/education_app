import 'package:demo/app/modules/currency/presenter/components/select_currency/currency_list_view.dart';
import 'package:demo/app/modules/currency/presenter/components/select_currency/currency_select_appbar.dart';
import 'package:demo/app/modules/currency/presenter/components/select_currency/procced_currency_button.dart';
import 'package:demo/app/modules/currency/presenter/components/select_currency/search_currency.dart';
import 'package:flutter/material.dart';

class CurrencySelectView extends StatelessWidget {
  const CurrencySelectView({this.isRight = true, super.key});
  final bool isRight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CurrencySelectAppBar(isRight: isRight),
      body: Column(
        children: [
          const SearchCurrency(),
          CurrencyListView(isRight: isRight),
          if (isRight) const ProceedCurrencyButton(),
        ],
      ),
    );
  }
}
