import 'package:asp/asp.dart';
import 'package:demo/app/modules/currency/presenter/interactor/state/currency_state.dart';
import 'package:demo/core/common/widgets/simple_text.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:demo/core/utils/core_utils.dart';
import 'package:flutter/material.dart';

class CurrencyConvertedList extends StatelessWidget {
  const CurrencyConvertedList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RxBuilder(
      builder: (context) {
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
            itemCount: cGroupState.value.currencies.length,
            itemBuilder: (context, index) {
              final currrency = cGroupState.value.currencies[index];
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
                  text: currrency.conversion,
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
