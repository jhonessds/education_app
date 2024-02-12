import 'package:demo/app/modules/currency/presenter/interactor/state/currency_state.dart';

void changeAllCurrenciesCheck({required bool checked}) {
  for (final c in currencyAvailableState.value) {
    c.checked = checked;
  }
  checkAllCurrencyState.setValue(checked);
  currencyAvailableState.call();
}
