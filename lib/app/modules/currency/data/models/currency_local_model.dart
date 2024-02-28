import 'package:demo/app/modules/currency/domain/entities/currency_local.dart';

class CurrencyLocalModel extends CurrencyLocal {
  CurrencyLocalModel({
    required super.code,
    required super.name,
    required super.symbol,
    required super.flag,
    required super.number,
    required super.decimalDigits,
    required super.namePlural,
    required super.symbolOnLeft,
    required super.decimalSeparator,
    required super.thousandsSeparator,
    required super.spaceBetweenAmountAndSymbol,
  });

  factory CurrencyLocalModel.fromMap(Map<String, dynamic> map) {
    return CurrencyLocalModel(
      code: map['code'] as String,
      name: map['name'] as String,
      symbol: map['symbol'] as String,
      flag: map['flag'] as String,
      number: map['number'] as int,
      decimalDigits: map['decimal_digits'] as int,
      namePlural: map['name_plural'] as String,
      decimalSeparator: map['decimal_separator'] as String,
      thousandsSeparator: map['thousands_separator'] as String,
      symbolOnLeft: map['symbol_on_left'] as bool,
      spaceBetweenAmountAndSymbol:
          map['space_between_amount_and_symbol'] as bool,
    );
  }
}
