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
    required super.cad,
    required super.aud,
    required super.jpy,
    required super.cny,
    required super.btc,
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
      cad: CurrencyModel.fromMap(
        map['CAD'] as Map<String, dynamic>,
        code: 'CAD',
      ),
      aud: CurrencyModel.fromMap(
        map['AUD'] as Map<String, dynamic>,
        code: 'AUD',
      ),
      jpy: CurrencyModel.fromMap(
        map['JPY'] as Map<String, dynamic>,
        code: 'JPY',
      ),
      cny: CurrencyModel.fromMap(
        map['CNY'] as Map<String, dynamic>,
        code: 'CNY',
      ),
      btc: CurrencyModel.fromMap(
        map['BTC'] as Map<String, dynamic>,
        code: 'BTC',
      ),
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
    Currency? cad,
    Currency? aud,
    Currency? jpy,
    Currency? cny,
    Currency? btc,
  }) {
    return CurrencyPriceModel(
      usd: usd ?? this.usd,
      eur: eur ?? this.eur,
      gbp: gbp ?? this.gbp,
      ars: ars ?? this.ars,
      brl: brl ?? this.brl,
      cad: cad ?? this.cad,
      aud: aud ?? this.aud,
      jpy: jpy ?? this.jpy,
      cny: cny ?? this.cny,
      btc: btc ?? this.btc,
    );
  }

  Map<String, dynamic> toMap() => {
        'USD': usd,
        'EUR': eur,
        'GBP': gbp,
        'ARS': ars,
        'BRL': brl,
        'CAD': cad,
        'AUD': aud,
        'JPY': jpy,
        'CNY': cny,
        'BTC': btc,
      };

  String toJson() => json.encode(toMap());

  List<Currency> getProperties() {
    return [usd, eur, gbp, ars, brl, cad, aud, jpy, cny, btc];
  }
}
