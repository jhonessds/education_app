import 'package:demo/app/modules/currency/presenter/components/converter/currency_converted_list.dart';
import 'package:demo/app/modules/currency/presenter/components/converter/one_currency.dart';
import 'package:demo/app/modules/currency/presenter/controllers/state/currency_state.dart';
import 'package:demo/app/modules/currency/presenter/controllers/store/currency_store.dart';
import 'package:demo/app/modules/currency/presenter/widgets/currency_converter/card_converter.dart';
import 'package:demo/app/modules/currency/presenter/widgets/currency_converter/convert_button.dart';
import 'package:demo/app/modules/currency/presenter/widgets/currency_converter/top_group.dart';
import 'package:demo/app/modules/currency/presenter/widgets/currency_converter/waves.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CurrencyConverterView extends StatelessWidget {
  const CurrencyConverterView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final store = Modular.get<CurrencyListStore>();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SizedBox(
        height: context.height,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            const Waves(),
            const TopGroup(),
            CardConverter(formKey: formKey),
            ConvertButton(formKey: formKey),
            ValueListenableBuilder<CurrencyListState>(
              valueListenable: store,
              builder: (context, value, child) {
                if (store.group.hasOne) {
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
