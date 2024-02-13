import 'package:demo/app/modules/currency/presenter/interactor/state/currency_state.dart';

void changeAllCurrenciesCheck({required bool checked}) {
  for (final c in currencyState.value) {
    c.checked = checked;
  }
  checkAllCurrencyState.setValue(checked);
  currencyState.call();
}
