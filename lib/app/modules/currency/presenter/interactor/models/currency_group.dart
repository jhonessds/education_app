import 'package:demo/app/modules/currency/presenter/interactor/models/currency_selectable.dart';

class CurrencyGroup {
  CurrencyGroup({required this.name, required this.currencies});

  final String name;
  final List<CurrencySelectable> currencies;
}
