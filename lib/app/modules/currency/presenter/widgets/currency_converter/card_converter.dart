import 'package:demo/app/modules/currency/presenter/components/currency_converter/select_currency_left.dart';
import 'package:demo/app/modules/currency/presenter/components/currency_converter/select_currency_right.dart';
import 'package:demo/core/common/widgets/custom_input.dart';
import 'package:demo/core/common/widgets/simple_text.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class CardConverter extends StatelessWidget {
  const CardConverter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.only(
        left: 15,
        right: 15,
        top: context.height * 0.16,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(
              left: 23,
              right: 23,
              bottom: 20,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SelectCurrencyLeft(),
                SimpleText(
                  text: 'to',
                  fontWeight: FontWeight.bold,
                ),
                SelectCurrencyRight(),
              ],
            ),
          ),
          const CustomInput(
            mgLeft: 30,
            borderRadius: 25,
            mgRight: 30,
            mgBottom: 40,
          ),
        ],
      ),
    );
  }
}
