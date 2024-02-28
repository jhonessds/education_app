// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'package:demo/app/modules/currency/domain/entities/currency_simple.dart';
import 'package:demo/core/utils/typedefs.dart';

class CurrencySimpleModel extends CurrencySimple {
  CurrencySimpleModel({
    required super.code,
    super.conversion,
    super.id,
  });

  factory CurrencySimpleModel.fromMap(
    Map<String, dynamic> map, {
    String? code,
  }) {
    return CurrencySimpleModel(
      id: map['id'] as int? ?? 0,
      code: (code ?? (map['code'] as String?)) ?? '',
      conversion: map['name'] as String? ?? '',
    );
  }

  factory CurrencySimpleModel.fromJson(String source) =>
      CurrencySimpleModel.fromMap(json.decode(source) as Map<String, dynamic>);

  CurrencySimpleModel copyWith({
    int? id,
    String? code,
    String? conversion,
  }) {
    return CurrencySimpleModel(
      id: id ?? this.id,
      code: code ?? this.code,
      conversion: conversion ?? this.conversion,
    );
  }

  DataMap toMap() => {
        'id': id,
        'code': code,
        'conversion': conversion,
      };

  String toJson() => json.encode(toMap());
}
