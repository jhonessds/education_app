import 'package:asp/asp.dart';
import 'package:demo/app/modules/currency/presenter/interactor/models/currency_group.dart';
import 'package:demo/app/modules/currency/presenter/interactor/state/currency_state.dart';
import 'package:demo/app/modules/currency/presenter/views/converter/currency_select_view.dart';
import 'package:demo/core/common/widgets/simple_text.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:demo/core/utils/core_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SelectCurrencyRight extends StatelessWidget {
  const SelectCurrencyRight({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RxBuilder(
      builder: (context) {
        return TextButton(
          onPressed: () async {
            final result = await Modular.to.push<CurrencyGroup?>(
              CoreUtils.push<CurrencyGroup?>(
                const CurrencySelectView(),
              ),
            );

            if (result != null) cGroupState.setValue(result);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CoreUtils.getFlag(
                currencyCode: cGroupState.value.currencyCode(),
              ),
              const SizedBox(width: 10),
              SimpleText(
                text: cGroupState.value.currencyCode(),
                color: context.theme.colorScheme.onBackground,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              const SizedBox(width: 10),
              Icon(
                Icons.arrow_drop_down_outlined,
                color: context.theme.colorScheme.onBackground,
              ),
            ],
          ),
        );
      },
    );
  }
}
