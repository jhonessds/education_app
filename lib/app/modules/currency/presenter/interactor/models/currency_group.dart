import 'package:demo/app/modules/currency/domain/entities/currency.dart';

class CurrencyGroup {
  CurrencyGroup({required this.name, required this.currencies});

  final String name;
  final List<Currency> currencies;

  bool get hasOne => currencies.length == 1;
}
