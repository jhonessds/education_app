import 'package:demo/app/modules/currency/domain/entities/currency.dart';
import 'package:equatable/equatable.dart';

abstract class CurrencyPrice extends Equatable {
  const CurrencyPrice({
    required this.usd,
    required this.eur,
    required this.gbp,
    required this.ars,
    required this.brl,
  });

  final Currency usd;
  final Currency eur;
  final Currency gbp;
  final Currency ars;
  final Currency brl;

  @override
  List<Object> get props => [usd, eur, gbp, ars, brl];
}
