// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:demo/app/modules/currency/domain/entities/currency_history.dart';
import 'package:demo/core/utils/typedefs.dart';

class CurrencyHistoryModel extends CurrencyHistory {
  CurrencyHistoryModel({
    required super.date,
    required super.currency,
    required super.origin,
    required super.destiny,
    super.currencyConverted,
    super.id,
  });

  factory CurrencyHistoryModel.fromMap(Map<String, dynamic> map) {
    return CurrencyHistoryModel(
      id: map['id'] as int? ?? 0,
      currency: map['currency'] as double? ?? 0.0,
      currencyConverted: map['currencyConverted'] as String?,
      origin: map['origin'] as String? ?? '',
      destiny: map['destiny'] as String? ?? '',
      date: map['date'] as DateTime? ?? DateTime.now(),
    );
  }

  factory CurrencyHistoryModel.fromJson(String source) =>
      CurrencyHistoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  CurrencyHistoryModel copyWith({
    int? id,
    double? currency,
    String? currencyConverted,
    String? origin,
    String? destiny,
    DateTime? date,
  }) {
    return CurrencyHistoryModel(
      id: id ?? this.id,
      currency: currency ?? this.currency,
      currencyConverted: currencyConverted ?? this.currencyConverted,
      origin: origin ?? this.origin,
      destiny: destiny ?? this.destiny,
      date: date ?? this.date,
    );
  }

  DataMap toMap() => {
        'id': id,
        'currency': currency,
        'currencyConverted': currencyConverted,
        'origin': origin,
        'destiny': destiny,
        'date': date,
      };

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'CurrencyHistory(currency: $currency, currencyConverted:'
        ' $currencyConverted, display: $origin, date: $date)';
  }
}
