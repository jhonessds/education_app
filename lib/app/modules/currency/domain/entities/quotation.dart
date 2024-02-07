import 'package:demo/app/modules/currency/domain/entities/currency.dart';

abstract class Quotation {
  Quotation({
    required this.date,
    required this.currrencies,
    this.id = 0,
  });

  final int id;
  final DateTime date;
  final List<Currency> currrencies;

  @override
  String toString() => 'Quotation(id: $id, date: $date, currrencies:'
      ' $currrencies)';
}
