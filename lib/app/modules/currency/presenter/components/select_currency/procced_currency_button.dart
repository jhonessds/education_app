import 'package:asp/asp.dart';
import 'package:demo/app/modules/currency/presenter/interactor/actions/currency_action.dart';
import 'package:demo/app/modules/currency/presenter/interactor/models/currency_group.dart';
import 'package:demo/app/modules/currency/presenter/interactor/state/currency_state.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProceedCurrencyButton extends StatefulWidget {
  const ProceedCurrencyButton({
    super.key,
  });

  @override
  State<ProceedCurrencyButton> createState() => _ProceedCurrencyButtonState();
}

class _ProceedCurrencyButtonState extends State<ProceedCurrencyButton> {
  late RxDisposer _disposer;
  bool enableButton = false;

  @override
  void initState() {
    super.initState();
    _disposer = rxObserver(
      () => currencyAvailableState.value,
      effect: (value) {
        final anyChecked = value?.any((element) => element.checked);
        if (anyChecked != null && anyChecked) {
          setState(() => enableButton = true);
        } else {
          setState(() => enableButton = false);
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
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
      width: context.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          backgroundColor: context.theme.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: enableButton
            ? () async {
                final result = currencyAvailableState.value
                    .where((e) => e.checked)
                    .toList();
                changeAllCurrenciesCheck(checked: false);
                Modular.to.pop(CurrencyGroup(name: 'GRP', currencies: result));
              }
            : null,
        child: const Text(
          'Proceed',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
