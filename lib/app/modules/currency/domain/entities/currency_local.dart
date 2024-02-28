abstract class CurrencyLocal {
  CurrencyLocal({
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
