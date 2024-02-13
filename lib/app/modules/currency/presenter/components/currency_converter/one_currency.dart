import 'package:asp/asp.dart';
import 'package:demo/app/modules/currency/presenter/interactor/state/currency_state.dart';
import 'package:demo/core/common/widgets/simple_text.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:demo/core/utils/core_utils.dart';
import 'package:flutter/material.dart';

class OneCurrency extends StatelessWidget {
  const OneCurrency({super.key});

  @override
  Widget build(BuildContext context) {
    final currrencySelected = currencyGroupState.value.currencies.first;
    final currency = double.tryParse(currencyCtrlState.value.text) ?? 0;
    return RxBuilder(
      builder: (context) {
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
                  CoreUtils.getFlag(
                    currencyCode: currrencySelected.code,
                    size: 50,
                  ),
                  SimpleText(
                    mgLeft: 10,
                    mgRight: 5,
                    text: (currency / currrencySelected.buy).toStringAsFixed(2),
                    fontWeight: FontWeight.bold,
                    fontSize: 45,
                  ),
                  const Icon(
                    Icons.arrow_upward,
                    color: Colors.green,
                  ),
                ],
              ),
              SimpleText(
                text: '1 USD = 1.129 USD',
                color: context.theme.disabledColor,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        );
      },
    );
  }
}
