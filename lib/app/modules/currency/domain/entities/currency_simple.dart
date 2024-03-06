// ignore_for_file: must_be_immutable

import 'package:demo/app/modules/currency/domain/entities/currency_group.dart';
import 'package:demo/app/modules/currency/domain/entities/currency_history.dart';
import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class CurrencySimple extends Equatable {
  CurrencySimple({
    required this.code,
    this.id = 0,
    this.conversion = '0.0',
  });

  int id;
  final String code;
  String conversion;

  final currencyGroup = ToOne<CurrencyGroup>();
  final currencyHistory = ToMany<CurrencyHistory>();

  @override
  List<Object> get props => [id, code, conversion];
}
