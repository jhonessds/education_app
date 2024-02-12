import 'package:asp/asp.dart';
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
                if (currencyGroupState.value.currencies.length == 1) {
                  final currrency = currencyGroupState.value.currencies[0];
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
                              currencyCode: currrency.code,
                              size: 50,
                            ),
                            SimpleText(
                              mgLeft: 10,
                              mgRight: 5,
                              text: currrency.value.toString(),
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
                        trailing: SimpleText(
                          text: currrency.value.toString(),
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
