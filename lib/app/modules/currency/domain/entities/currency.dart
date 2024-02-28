// ignore_for_file: must_be_immutable

import 'package:demo/app/modules/currency/domain/entities/quotation.dart';
import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Currency extends Equatable {
  Currency({
    required this.code,
    required this.name,
    required this.buy,
    this.id = 0,
    this.checked = false,
    this.sell,
    this.conversion = '0.0',
  });

  int id;
  final String code;
  final String name;
  final double buy;
  final double? sell;
  @Transient()
  bool checked;
  @Transient()
  String conversion;

  final quotation = ToOne<Quotation>();
  final currencyGroup = ToOne<Quotation>();

  @override
  String toString() {
    return 'Currency(code: $code, name: $name, buy: $buy, sell: $sell)';
  }

  @override
  List<Object> get props => [id, code, name];
}
