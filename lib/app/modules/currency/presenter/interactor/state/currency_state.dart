import 'package:asp/asp.dart';
import 'package:demo/app/modules/currency/domain/entities/currency.dart';
import 'package:demo/app/modules/currency/presenter/interactor/models/currency_group.dart';
import 'package:demo/app/modules/currency/presenter/interactor/models/currency_selectable.dart';

Atom<List<Currency>> currencyState = Atom<List<Currency>>([]);
Atom<CurrencySelectable> currencyLeftSate = Atom<CurrencySelectable>(
  CurrencySelectable(code: 'USD', name: 'Dollar'),
);
Atom<CurrencyGroup> currencyGroupState = Atom<CurrencyGroup>(
  CurrencyGroup(
    name: 'EUR',
    currencies: [
      CurrencySelectable(
        code: 'EUR',
        name: 'Euro',
      ),
    ],
  ),
);
Atom<bool> checkAllCurrencyState = Atom<bool>(false);

Atom<List<CurrencySelectable>> currencyAvailableState =
    Atom<List<CurrencySelectable>>([
  CurrencySelectable(code: 'USD', name: 'Dollar'),
  CurrencySelectable(code: 'EUR', name: 'Euro'),
  CurrencySelectable(code: 'GBP', name: 'Pound Sterling'),
  CurrencySelectable(code: 'ARS', name: 'Argentine Peso'),
  CurrencySelectable(code: 'BRL', name: 'Brazilian Real'),
  CurrencySelectable(code: 'CAD', name: 'Canadian Dollar'),
  CurrencySelectable(code: 'AUD', name: 'Australian Dollar'),
  CurrencySelectable(code: 'JPY', name: 'Japanese Yen'),
  CurrencySelectable(code: 'CNY', name: 'Renminbi'),
  CurrencySelectable(code: 'BTC', name: 'Bitcoin'),
]);
