import 'package:demo/app/modules/currency/presenter/controllers/state/currency_state.dart';
import 'package:demo/app/modules/currency/presenter/controllers/store/currency_store.dart';
import 'package:demo/app/modules/currency/presenter/views/converter/currency_select_view.dart';
import 'package:demo/core/common/widgets/simple_text.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:demo/core/utils/core_utils.dart';
import 'package:demo/core/utils/currency_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SelectCurrencyLeft extends StatelessWidget {
  const SelectCurrencyLeft({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final store = Modular.get<CurrencyListStore>();
    return ValueListenableBuilder<CurrencyListState>(
      valueListenable: store,
      builder: (context, value, _) {
        return TextButton(
          onPressed: () {
            Modular.to.push(
              CoreUtils.push<void>(
                const CurrencySelectView(isRight: false),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CurrencyUtils.getFlag(store.currencyLeft),
              const SizedBox(width: 10),
              SimpleText(
                text: store.currencyLeft ?? 'Select',
                color: context.theme.colorScheme.onBackground,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
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
