import 'package:demo/app/modules/currency/data/models/currency_group_model.dart';
import 'package:demo/app/modules/currency/presenter/controllers/state/currency_state.dart';
import 'package:demo/app/modules/currency/presenter/controllers/store/currency_store.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProceedCurrencyButton extends StatelessWidget {
  const ProceedCurrencyButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final store = Modular.get<CurrencyListStore>();

    return ValueListenableBuilder<CurrencyListState>(
      valueListenable: store,
      builder: (context, value, child) {
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
            onPressed: store.group.currencies.isNotEmpty
                ? () => Modular.to.pop()
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
      },
    );
  }
}
