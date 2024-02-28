import 'package:demo/app/modules/currency/presenter/controllers/state/currency_state.dart';
import 'package:demo/app/modules/currency/presenter/controllers/store/currency_store.dart';
import 'package:demo/core/common/widgets/simple_text.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CurrencySelectAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  const CurrencySelectAppBar({
    required this.isRight,
    super.key,
  });
  final bool isRight;

  @override
  State<CurrencySelectAppBar> createState() => _CurrencySelectAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CurrencySelectAppBarState extends State<CurrencySelectAppBar> {
  @override
  Widget build(BuildContext context) {
    final store = Modular.get<CurrencyListStore>();

    return AppBar(
      backgroundColor: Colors.transparent,
      iconTheme: context.theme.iconTheme,
      title: SimpleText(
        text: 'Currencies',
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: context.theme.colorScheme.onBackground,
      ),
      actions: [
        if (widget.isRight && mounted)
          ValueListenableBuilder<CurrencyListState>(
            valueListenable: store,
            builder: (context, value, child) {
              return Checkbox(
                value: store.checkAllCurrency,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(99),
                ),
                onChanged: (value) {
                  store.checkAll(check: !store.checkAllCurrency);
                },
              );
            },
          ),
      ],
    );
  }
}
