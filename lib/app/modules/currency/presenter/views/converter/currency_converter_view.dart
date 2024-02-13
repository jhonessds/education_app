import 'package:asp/asp.dart';
import 'package:demo/app/modules/currency/presenter/components/currency_converter/one_currency.dart';
import 'package:demo/app/modules/currency/presenter/interactor/state/currency_state.dart';
import 'package:demo/app/modules/currency/presenter/widgets/currency_converter/card_converter.dart';
import 'package:demo/app/modules/currency/presenter/widgets/currency_converter/convert_button.dart';
import 'package:demo/app/modules/currency/presenter/widgets/currency_converter/top_group.dart';
import 'package:demo/app/modules/currency/presenter/widgets/currency_converter/waves.dart';
import 'package:demo/core/common/widgets/simple_text.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:demo/core/utils/core_utils.dart';
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
                if (currencyGroupState.value.hasOne) {
                  return const OneCurrency();
                }
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
                    itemCount: currencyGroupState.value.currencies.length,
                    itemBuilder: (context, index) {
                      final currrency =
                          currencyGroupState.value.currencies[index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CoreUtils.getFlag(
                          currencyCode: currrency.code,
                        ),
                        title: SimpleText(
                          text: currrency.code,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        trailing: const SimpleText(
                          text: 'currrency.value.toString()',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
