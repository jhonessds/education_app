import 'package:demo/app/modules/currency/data/models/currency_history_model.dart';
import 'package:demo/app/modules/currency/presenter/controllers/currency_controller.dart';
import 'package:demo/app/modules/currency/presenter/interactor/actions/currency_action.dart';
import 'package:demo/app/modules/currency/presenter/interactor/state/currency_state.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:demo/core/utils/core_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ConvertButton extends StatelessWidget {
  const ConvertButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: context.height * 0.32,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 30,
          ),
          backgroundColor: context.theme.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () async {
          convert();
          final controller = Modular.get<CurrencyController>();
          final history = CurrencyHistoryModel(
            date: DateTime.now(),
            currency: double.tryParse(currencyCtrlState.value.text) ?? 0,
            currencyConverted: cGroupState.value.hasOne
                ? cGroupState.value.currencies.first.conversion
                : null,
            origin: currencyLeftSate.value!.code,
            destiny: cGroupState.value.hasOne
                ? cGroupState.value.currencies.first.code
                : cGroupState.value.name,
          );
          final result = await controller.saveHistory(history: history);
          if (!result) {
            CoreUtils.bottomSnackBar(controller.errorMessage);
          }
        },
        child: const Text(
          'Convert',
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
