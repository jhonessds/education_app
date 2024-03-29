// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'package:demo/app/modules/currency/domain/entities/currency.dart';
import 'package:demo/core/utils/typedefs.dart';

class CurrencyModel extends Currency {
  CurrencyModel({
    required super.code,
    required super.name,
    required super.buy,
    super.sell,
    super.id,
  });

  factory CurrencyModel.fromMap(Map<String, dynamic> map, {String? code}) {
    return CurrencyModel(
      id: map['id'] as int? ?? 0,
      code: (code ?? (map['code'] as String?)) ?? '',
      name: map['name'] as String? ?? '',
      buy: map['buy'] as double? ?? 0.0,
      sell: map['sell'] as double?,
    );
  }

  factory CurrencyModel.brl() {
    return CurrencyModel(
      code: 'BRL',
      name: 'Brazilian Real',
      buy: 1,
    );
  }

  factory CurrencyModel.fromJson(String source) =>
      CurrencyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  CurrencyModel copyWith({
    int? id,
    String? code,
    String? name,
    double? buy,
    double? sell,
    double? variation,
  }) {
    return CurrencyModel(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      buy: buy ?? this.buy,
      sell: sell ?? this.sell,
    );
  }

  DataMap toMap() => {
        'id': id,
        'code': code,
        'name': name,
        'buy': buy,
        'sell': sell,
      };

  String toJson() => json.encode(toMap());
}
