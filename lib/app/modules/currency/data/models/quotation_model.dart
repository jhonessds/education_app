// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:demo/app/modules/currency/data/models/currency_model.dart';
import 'package:demo/app/modules/currency/domain/entities/currency.dart';
import 'package:demo/app/modules/currency/domain/entities/quotation.dart';
import 'package:demo/core/utils/typedefs.dart';
import 'package:objectbox/objectbox.dart';

class QuotationModel extends Quotation {
  QuotationModel({
    required super.date,
    required super.currencies,
    super.id,
  });

  factory QuotationModel.fromMap(Map<String, dynamic> map) {
    return QuotationModel(
      id: map['id'] as int? ?? 0,
      date: map['date'] as DateTime? ?? DateTime.now(),
      currencies: ToMany<Currency>(
        items: List<CurrencyModel>.from(
          (map['currencies'] as List<Map<String, dynamic>>)
              .map(CurrencyModel.fromMap),
        ),
      ),
    );
  }

  factory QuotationModel.fromJson(String source) =>
      QuotationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  QuotationModel copyWith({
    int? id,
    DateTime? date,
    ToMany<Currency>? currrencies,
  }) {
    return QuotationModel(
      id: id ?? this.id,
      date: date ?? this.date,
      currencies: currrencies ?? currencies,
    );
  }

  DataMap toMap() => {
        'id': id,
        'date': date,
        'currencies':
            currencies.map((x) => (x as CurrencyModel).toMap()).toList(),
      };

  String toJson() => json.encode(toMap());
}
