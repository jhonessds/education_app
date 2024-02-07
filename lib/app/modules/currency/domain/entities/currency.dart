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
    required this.variation,
    this.id = 0,
    this.sell,
  });

  int id;
  final String code;
  final String name;
  final double buy;
  final double? sell;
  final double variation;

  final quotation = ToOne<Quotation>();

  @override
  String toString() {
    return 'Currency(code: $code, name: $name, buy: $buy, sell: $sell,'
        ' variation: $variation)';
  }

  @override
  List<Object> get props => [id, code, name];
}
