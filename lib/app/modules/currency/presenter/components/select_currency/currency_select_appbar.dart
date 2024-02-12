import 'package:asp/asp.dart';
import 'package:demo/app/modules/currency/presenter/interactor/actions/currency_action.dart';
import 'package:demo/app/modules/currency/presenter/interactor/state/currency_state.dart';
import 'package:demo/core/common/widgets/simple_text.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class CurrencySelectAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CurrencySelectAppBar({
    required this.isRight,
    super.key,
  });
  final bool isRight;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      iconTheme: context.theme.iconTheme,
      title: SimpleText(
        text: 'Currencies',
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: context.theme.colorScheme.onBackground,
      ),
      actions: isRight
          ? [
              RxBuilder(
                builder: (context) {
                  return Checkbox(
                    value: checkAllCurrencyState.value,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(99),
                    ),
                    onChanged: (value) {
                      changeAllCurrenciesCheck(checked: value ?? false);
                    },
                  );
                },
              ),
            ]
          : [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
