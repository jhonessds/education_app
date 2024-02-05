import 'package:demo/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class CurrencyView extends StatelessWidget {
  const CurrencyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: context.theme.iconTheme,
        backgroundColor: Colors.transparent,
        title: Text(
          'Currency',
          style: TextStyle(color: context.theme.colorScheme.onBackground),
        ),
        centerTitle: true,
      ),
    );
  }
}
