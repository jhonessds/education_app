import 'package:asp/asp.dart';
import 'package:demo/app/modules/currency/domain/entities/currency.dart';
import 'package:demo/app/modules/currency/presenter/interactor/models/currency_group.dart';
import 'package:flutter/material.dart';

Atom<List<Currency>> currencyState = Atom<List<Currency>>([]);

Atom<Currency?> currencyLeftSate = Atom<Currency?>(null);

Atom<CurrencyGroup> currencyGroupState = Atom<CurrencyGroup>(
  CurrencyGroup(
    name: 'GRP',
    currencies: [],
  ),
);
Atom<bool> checkAllCurrencyState = Atom<bool>(false);

Atom<TextEditingController> currencyCtrlState =
    Atom<TextEditingController>(TextEditingController());
