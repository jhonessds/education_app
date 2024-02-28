// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class CurrencyGroup extends Equatable {
  CurrencyGroup({
    required this.name,
    required this.currencies,
    this.code = 'GRP',
    this.id = 0,
  });

  int id;
  final String name;
  final String code;
  final List<String> currencies;

  @override
  List<Object> get props => [id];
}
