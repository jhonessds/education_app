// ignore_for_file: must_be_immutable

import 'package:demo/app/modules/currency/domain/entities/currency.dart';
import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Quotation extends Equatable {
  Quotation({
    required this.date,
    required this.currrencies,
    this.id = 0,
  });

  int id;
  @Property(type: PropertyType.date)
  final DateTime date;
  @Backlink('quotation')
  ToMany<Currency> currrencies = ToMany<Currency>();

  @override
  String toString() => 'Quotation(id: $id, date: $date, currrencies:'
      ' $currrencies)';

  @override
  List<Object> get props => [id];
}
