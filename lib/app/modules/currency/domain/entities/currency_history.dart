// ignore_for_file: must_be_immutable

import 'package:demo/app/modules/currency/domain/entities/currency_simple.dart';
import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class CurrencyHistory extends Equatable {
  CurrencyHistory({
    required this.date,
    required this.amount,
    required this.currencyOrigin,
    required this.currencies,
    required this.isGroup,
    this.groupName,
    this.id = 0,
  });

  int id;
  final String currencyOrigin;
  final double amount;
  final String? groupName;
  final bool isGroup;
  @Property(type: PropertyType.date)
  final DateTime date;

  @Backlink('currencyHistory')
  ToMany<CurrencySimple> currencies = ToMany<CurrencySimple>();

  @override
  List<Object> get props => [id];
}
