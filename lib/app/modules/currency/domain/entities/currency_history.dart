// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class CurrencyHistory extends Equatable {
  CurrencyHistory({
    required this.date,
    required this.currency,
    required this.origin,
    required this.destiny,
    this.currencyConverted,
    this.id = 0,
  });

  int id;
  final double currency;
  final String? currencyConverted;
  final String origin;
  final String destiny;
  @Property(type: PropertyType.date)
  final DateTime date;

  @override
  List<Object> get props => [id];
}
