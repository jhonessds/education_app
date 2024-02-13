import 'package:asp/asp.dart';
import 'package:demo/app/modules/currency/presenter/components/converter/currency_converted_list.dart';
import 'package:demo/app/modules/currency/presenter/components/converter/one_currency.dart';
import 'package:demo/app/modules/currency/presenter/interactor/state/currency_state.dart';
import 'package:demo/app/modules/currency/presenter/widgets/currency_converter/card_converter.dart';
import 'package:demo/app/modules/currency/presenter/widgets/currency_converter/convert_button.dart';
import 'package:demo/app/modules/currency/presenter/widgets/currency_converter/top_group.dart';
import 'package:demo/app/modules/currency/presenter/widgets/currency_converter/waves.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class CurrencyConverterView extends StatelessWidget {
  const CurrencyConverterView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: context.height,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            const Waves(),
            const TopGroup(),
            const CardConverter(),
            const ConvertButton(),
            RxBuilder(
              builder: (context) {
                if (cGroupState.value.hasOne) {
                  return const OneCurrency();
                }
                return const CurrencyConvertedList();
              },
            ),
          ],
        ),
      ),
    );
  }
}
