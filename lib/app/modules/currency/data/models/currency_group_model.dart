// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'package:demo/app/modules/currency/domain/entities/currency_group.dart';
import 'package:demo/core/utils/typedefs.dart';

class CurrencyGroupModel extends CurrencyGroup {
  CurrencyGroupModel({
    required super.name,
    required super.currencies,
    super.code,
    super.id,
  });

  factory CurrencyGroupModel.fromMap(Map<String, dynamic> map) {
    return CurrencyGroupModel(
      id: map['id'] as int? ?? 0,
      code: map['code'] as String? ?? '',
      name: map['name'] as String? ?? '',
      currencies: List<String>.from(map['currencies'] as List<String>),
    );
  }

  factory CurrencyGroupModel.fromJson(String source) =>
      CurrencyGroupModel.fromMap(json.decode(source) as Map<String, dynamic>);

  bool get hasOne => currencies.length == 1;
  bool get hasZero => currencies.isEmpty;

  String currencyCode() {
    if (currencies.isEmpty) {
      return 'Select';
    } else if (currencies.length == 1) {
      return currencies.first;
    } else {
      return 'Group';
    }
  }

  CurrencyGroupModel copyWith({
    int? id,
    String? code,
    String? name,
    List<String>? currencies,
  }) {
    return CurrencyGroupModel(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      currencies: currencies ?? this.currencies,
    );
  }

  DataMap toMap() => {
        'id': id,
        'name': name,
        'code': code,
        'currrencies': currencies.toList(),
      };

  String toJson() => json.encode(toMap());
}
