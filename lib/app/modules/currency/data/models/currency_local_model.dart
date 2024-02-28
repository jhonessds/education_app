class CurrencyLocalModel {
  CurrencyLocalModel({
    required this.code,
    required this.name,
    required this.symbol,
    required this.flag,
    required this.number,
    required this.decimalDigits,
    required this.namePlural,
    required this.symbolOnLeft,
    required this.decimalSeparator,
    required this.thousandsSeparator,
    required this.spaceBetweenAmountAndSymbol,
    this.checked = false,
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

  ///The currency code
  final String code;

  ///The currency name in English
  final String name;

  ///The currency symbol
  final String symbol;

  ///The currency flag code
  /// To get flag unicode(Emoji) use CurrencyUtils.currencyToEmoji
  final String flag;

  ///The currency number
  final int number;

  ///The currency decimal digits
  final int decimalDigits;

  ///The currency plural name in English
  final String namePlural;

  ///The decimal separator
  final String decimalSeparator;

  ///The thousands separator
  final String thousandsSeparator;

  ///True if symbol is on the Left of the amount
  final bool symbolOnLeft;

  ///True if symbol has space with amount
  final bool spaceBetweenAmountAndSymbol;

  bool checked;
}
