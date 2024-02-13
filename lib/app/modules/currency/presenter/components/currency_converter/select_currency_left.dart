import 'package:asp/asp.dart';
import 'package:demo/app/modules/currency/domain/entities/currency.dart';
import 'package:demo/app/modules/currency/presenter/interactor/state/currency_state.dart';
import 'package:demo/app/modules/currency/presenter/views/converter/currency_select_view.dart';
import 'package:demo/core/common/widgets/simple_text.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:demo/core/utils/core_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SelectCurrencyLeft extends StatefulWidget {
  const SelectCurrencyLeft({
    super.key,
  });

  @override
  State<SelectCurrencyLeft> createState() => _SelectCurrencyLeftState();
}

class _SelectCurrencyLeftState extends State<SelectCurrencyLeft> {
  @override
  Widget build(BuildContext context) {
    return RxBuilder(
      builder: (context) {
        return TextButton(
          onPressed: () async {
            final result = await Modular.to.push<Currency?>(
              CoreUtils.push<Currency?>(
                const CurrencySelectView(isRight: false),
              ),
            );

            if (result != null) currencyLeftSate.setValue(result);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CoreUtils.getFlag(currencyCode: currencyLeftSate.value!.code),
              const SizedBox(width: 10),
              SimpleText(
                text: currencyLeftSate.value!.code,
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
