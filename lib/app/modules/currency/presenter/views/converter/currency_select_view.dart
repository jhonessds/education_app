import 'package:asp/asp.dart';
import 'package:demo/app/modules/currency/presenter/components/select_currency/currency_list_view.dart';
import 'package:demo/app/modules/currency/presenter/components/select_currency/currency_select_appbar.dart';
import 'package:demo/app/modules/currency/presenter/components/select_currency/procced_currency_button.dart';
import 'package:demo/app/modules/currency/presenter/components/select_currency/search_currency.dart';
import 'package:demo/app/modules/currency/presenter/interactor/actions/currency_action.dart';
import 'package:demo/app/modules/currency/presenter/interactor/state/currency_state.dart';
import 'package:flutter/material.dart';

class CurrencySelectView extends StatefulWidget {
  const CurrencySelectView({this.isRight = true, super.key});
  final bool isRight;

  @override
  State<CurrencySelectView> createState() => _CurrencySelectViewState();
}

class _CurrencySelectViewState extends State<CurrencySelectView> {
  late RxDisposer _disposer;

  @override
  void initState() {
    super.initState();
    _disposer = rxObserver(
      () => currencyAvailableState.value,
      effect: (value) {
        final allIsChecked = value?.any((element) => element.checked == false);
        if (allIsChecked != null && !allIsChecked) {
          checkAllCurrencyState.setValue(true);
        } else {
          checkAllCurrencyState.setValue(false);
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
    return PopScope(
      onPopInvoked: (didPop) {
        changeAllCurrenciesCheck(checked: false);
      },
      child: Scaffold(
        appBar: CurrencySelectAppBar(isRight: widget.isRight),
        body: Column(
          children: [
            const SearchCurrency(),
            CurrencyListView(isRight: widget.isRight),
            if (widget.isRight) const ProceedCurrencyButton(),
          ],
        ),
      ),
    );
  }
}
