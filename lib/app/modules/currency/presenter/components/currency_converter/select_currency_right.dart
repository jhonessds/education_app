import 'package:asp/asp.dart';
import 'package:demo/app/modules/currency/presenter/interactor/models/currency_group.dart';
import 'package:demo/app/modules/currency/presenter/interactor/state/currency_state.dart';
import 'package:demo/app/modules/currency/presenter/views/converter/currency_select_view.dart';
import 'package:demo/core/common/widgets/simple_text.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:demo/core/utils/core_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:icons_plus/icons_plus.dart';

class SelectCurrencyRight extends StatefulWidget {
  const SelectCurrencyRight({
    super.key,
  });

  @override
  State<SelectCurrencyRight> createState() => _SelectCurrencyRightState();
}

class _SelectCurrencyRightState extends State<SelectCurrencyRight> {
  late RxDisposer _disposer;
  bool isOne = true;
  String currencyCode = 'EUR';

  @override
  void initState() {
    super.initState();
    _disposer = rxObserver(
      () => currencyGroupState.value,
      effect: (value) {
        final length = value?.currencies.length;
        if (length != null && length > 1) {
          setState(() => isOne = false);
        } else {
          setState(() {
            isOne = true;
            currencyCode = value!.currencies[0].code;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _disposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        final result = await Modular.to.push<CurrencyGroup?>(
          CoreUtils.push<CurrencyGroup?>(
            const CurrencySelectView(),
          ),
        );

        if (result != null) currencyGroupState.setValue(result);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (isOne)
            CoreUtils.getFlag(currencyCode: currencyCode)
          else
            const Icon(Bootstrap.currency_exchange),
          const SizedBox(width: 10),
          SimpleText(
            text: isOne ? currencyCode : currencyGroupState.value.name,
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
  }
}
