import 'dart:convert';

import 'package:demo/app/modules/currency/data/models/currency_model.dart';
import 'package:demo/app/modules/currency/domain/entities/currency.dart';
import 'package:demo/app/modules/currency/domain/entities/currency_price.dart';

class CurrencyPriceModel extends CurrencyPrice {
  const CurrencyPriceModel({
    required super.usd,
    required super.eur,
    required super.gbp,
    required super.ars,
    required super.brl,
  });

  factory CurrencyPriceModel.fromMap(Map<String, dynamic> map) {
    return CurrencyPriceModel(
      usd: CurrencyModel.fromMap(
        map['USD'] as Map<String, dynamic>,
        code: 'USD',
      ),
      eur: CurrencyModel.fromMap(
        map['EUR'] as Map<String, dynamic>,
        code: 'EUR',
      ),
      gbp: CurrencyModel.fromMap(
        map['GBP'] as Map<String, dynamic>,
        code: 'GBP',
      ),
      ars: CurrencyModel.fromMap(
        map['ARS'] as Map<String, dynamic>,
        code: 'ARS',
      ),
      brl: CurrencyModel.brl(),
    );
  }

  factory CurrencyPriceModel.fromJson(String source) =>
      CurrencyPriceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  CurrencyPriceModel copyWith({
    Currency? usd,
    Currency? eur,
    Currency? gbp,
    Currency? ars,
    Currency? brl,
  }) {
    return CurrencyPriceModel(
      usd: usd ?? this.usd,
      eur: eur ?? this.eur,
      gbp: gbp ?? this.gbp,
      ars: ars ?? this.ars,
      brl: brl ?? this.brl,
    );
  }

  Map<String, dynamic> toMap() => {
        'USD': usd,
        'EUR': eur,
        'GBP': gbp,
        'ARS': ars,
        'BRL': brl,
      };

  String toJson() => json.encode(toMap());

  List<Currency> getProperties() {
    return [usd, eur, gbp, ars, brl];
  }
}
