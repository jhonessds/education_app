import 'package:demo/app/modules/currency/presenter/controllers/currency_controller.dart';
import 'package:demo/app/modules/currency/presenter/controllers/store/currency_store.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:demo/core/utils/core_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ConvertButton extends StatelessWidget {
  const ConvertButton({
    required this.formKey,
    super.key,
  });

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    final store = Modular.get<CurrencyListStore>();
    final currencyCtrl = Modular.get<CurrencyController>();

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
          if (formKey.currentState!.validate()) {
            store.convert(currencyCtrl.currency);
            final result = await currencyCtrl.saveHistory();

            if (!result) {
              CoreUtils.bottomSnackBar(currencyCtrl.errorMessage);
            }
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
