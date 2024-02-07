import 'dart:convert';

import 'package:demo/app/modules/currency/data/models/currency_model.dart';
import 'package:demo/app/modules/currency/domain/entities/currency.dart';
import 'package:demo/app/modules/currency/domain/entities/quotation.dart';
import 'package:demo/core/utils/typedefs.dart';

class QuotationModel extends Quotation {
  QuotationModel({
    required super.date,
    required super.currrencies,
    super.id,
  });

  factory QuotationModel.fromMap(Map<String, dynamic> map) {
    return QuotationModel(
      id: map['id'] as int? ?? 0,
      date: map['date'] as DateTime? ?? DateTime.now(),
      currrencies: List<CurrencyModel>.from(
        (map['currrencies'] as List<Map<String, dynamic>>)
            .map(CurrencyModel.fromMap),
      ),
    );
  }

  factory QuotationModel.fromJson(String source) =>
      QuotationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  QuotationModel copyWith({
    int? id,
    DateTime? date,
    List<Currency>? currrencies,
  }) {
    return QuotationModel(
      id: id ?? this.id,
      date: date ?? this.date,
      currrencies: currrencies ?? this.currrencies,
    );
  }

  DataMap toMap() => {
        'id': id,
        'date': date,
        'currrencies':
            currrencies.map((x) => (x as CurrencyModel).toMap()).toList(),
      };

  String toJson() => json.encode(toMap());
}
