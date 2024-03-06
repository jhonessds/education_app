import 'package:demo/app/modules/currency/presenter/controllers/currency_controller.dart';
import 'package:demo/app/modules/currency/presenter/controllers/state/currency_state.dart';
import 'package:demo/app/modules/currency/presenter/controllers/store/currency_store.dart';
import 'package:demo/core/common/widgets/simple_text.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class OneCurrency extends StatelessWidget {
  const OneCurrency({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Modular.get<CurrencyListStore>();
    return ValueListenableBuilder<CurrencyListState>(
      valueListenable: store,
      builder: (context, value, _) {
        return Container(
          margin: EdgeInsets.only(
            top: context.height * 0.43,
            bottom: 20,
            left: 15,
            right: 15,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: SimpleText(
                      maxlines: 2,
                      mgLeft: 10,
                      mgRight: 5,
                      text: store.group.currencies.first.conversion,
                      fontWeight: FontWeight.bold,
                      fontSize: 45,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              SimpleText(
                text: store.currencyLeft != null
                    ? currencyText(store.currencyLeft!)
                    : '',
                color: context.theme.disabledColor,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        );
      },
    );
  }

  String currencyText(String code) {
    final fixed = code == 'BTC' ? 6 : 2;
    final store = Modular.get<CurrencyListStore>();
    final currencyCtrl = Modular.get<CurrencyController>();
    final buy = currencyCtrl.quotation.currencies
        .where((e) => e.code == store.currencyLeft)
        .first
        .buy;
    final right = currencyCtrl.quotation.currencies
        .where((e) => e.code == store.group.currencies.first.code)
        .first;
    return '1 $code ='
        ' ${((buy * 1) / right.buy).toStringAsFixed(fixed)}'
        ' ${right.code}';
  }
}
