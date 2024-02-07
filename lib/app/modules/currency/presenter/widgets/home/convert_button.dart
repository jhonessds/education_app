import 'package:demo/app/modules/currency/data/datasources/currency_datasource.dart';
import 'package:demo/core/abstraction/logger.dart';
import 'package:demo/core/extensions/context_extension.dart';
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
          final controller = Modular.get<CurrencyDataSource>();
          final result = await controller.getCotation();
          logger(result);
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
