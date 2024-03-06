// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:demo/app/modules/currency/data/models/currency_simple_model.dart';
import 'package:demo/app/modules/currency/domain/entities/currency_history.dart';
import 'package:demo/app/modules/currency/domain/entities/currency_simple.dart';
import 'package:demo/core/utils/typedefs.dart';
import 'package:objectbox/objectbox.dart';

class CurrencyHistoryModel extends CurrencyHistory {
  CurrencyHistoryModel({
    required super.date,
    required super.amount,
    required super.currencyOrigin,
    required super.currencies,
    required super.isGroup,
    super.groupName,
    super.id,
  });

  factory CurrencyHistoryModel.fromMap(Map<String, dynamic> map) {
    return CurrencyHistoryModel(
      id: map['id'] as int? ?? 0,
      amount: map['currency'] as double? ?? 0.0,
      currencyOrigin: map['currencyConverted'] as String? ?? '',
      isGroup: map['isGroup'] as bool? ?? false,
      groupName: map['groupName'] as String? ?? '',
      currencies: ToMany<CurrencySimple>(
        items: List<CurrencySimpleModel>.from(
          (map['currencies'] as List<Map<String, dynamic>>)
              .map(CurrencySimpleModel.fromMap),
        ),
      ),
      date: map['date'] as DateTime? ?? DateTime.now(),
    );
  }

  factory CurrencyHistoryModel.fromJson(String source) =>
      CurrencyHistoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  CurrencyHistoryModel copyWith({
    int? id,
    double? amount,
    String? currencyOrigin,
    String? groupName,
    bool? isGroup,
    ToMany<CurrencySimple>? currencies,
    DateTime? date,
  }) {
    return CurrencyHistoryModel(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      isGroup: isGroup ?? this.isGroup,
      currencyOrigin: currencyOrigin ?? this.currencyOrigin,
      groupName: groupName ?? this.groupName,
      currencies: currencies ?? this.currencies,
      date: date ?? this.date,
    );
  }

  DataMap toMap() => {
        'id': id,
        'isGroup': isGroup,
        'amount': amount,
        'groupName': groupName,
        'currrencies':
            currencies.map((x) => (x as CurrencySimpleModel).toMap()).toList(),
        'currencyOrigin': currencyOrigin,
        'date': date,
      };

  String toJson() => json.encode(toMap());
}
