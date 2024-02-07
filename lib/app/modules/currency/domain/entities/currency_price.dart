import 'package:demo/app/modules/currency/domain/entities/currency.dart';

abstract class CurrencyPrice {
  CurrencyPrice({
    required this.usd,
    required this.eur,
    required this.gbp,
    required this.ars,
    required this.cad,
    required this.aud,
    required this.jpy,
    required this.cny,
    required this.btc,
  });

  final Currency usd;
  final Currency eur;
  final Currency gbp;
  final Currency ars;
  final Currency cad;
  final Currency aud;
  final Currency jpy;
  final Currency cny;
  final Currency btc;
}
