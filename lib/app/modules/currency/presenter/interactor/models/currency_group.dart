import 'package:demo/app/modules/currency/domain/entities/currency.dart';

class CurrencyGroup {
  CurrencyGroup({
    required this.name,
    required this.code,
    required this.currencies,
  });

  final String name;
  final String code;
  final List<Currency> currencies;

  bool get hasOne => currencies.length == 1;
  bool get hasZero => currencies.isEmpty;

  String currencyCode() {
    if (currencies.isEmpty) {
      return 'Select';
    } else if (currencies.length == 1) {
      return currencies.first.code;
    } else {
      return name;
    }
  }
}
