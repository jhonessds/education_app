import 'package:demo/app/modules/currency/data/datasources/currencies.dart';
import 'package:demo/app/modules/currency/data/models/currency_group_model.dart';
import 'package:demo/app/modules/currency/data/models/currency_local_model.dart';
import 'package:demo/app/modules/currency/domain/entities/currency_local.dart';
import 'package:demo/app/modules/currency/presenter/controllers/state/currency_state.dart';
import 'package:flutter/material.dart';

class CurrencyListStore extends ValueNotifier<CurrencyListState> {
  CurrencyListStore() : super(SuccessCurrencyListState([]));

  bool checkAllCurrency = false;
  String? currencyLeft;
  List<CurrencyLocal> mainList = <CurrencyLocal>[];
  CurrencyGroupModel group = CurrencyGroupModel(
    name: 'GRP',
    currencies: const <String>[],
  );

  Future<void> getAll() async {
    value = LoadingCurrencyState();
    final result = currencies.map(CurrencyLocalModel.fromMap).toList();
    mainList.clear();
    mainList = result;
    for (final code in group.currencies) {
      final index = mainList.indexWhere((element) => element.code == code);
      mainList[index].checked = true;
    }
    value = SuccessCurrencyListState(mainList);
  }

  void onChangedSearch(String search) {
    value = SuccessCurrencyListState(mainList);
    if (search.trim().isEmpty) {
      return;
    } else {
      value = SuccessCurrencyListState(
        mainList.where(
          (item) {
            return item.name
                    .toUpperCase()
                    .contains(search.trim().toUpperCase()) ||
                item.code.toUpperCase().contains(search.trim().toUpperCase());
          },
        ).toList(),
      );
    }
  }

  void check({required int index, required bool check}) {
    final currencies = (value as SuccessCurrencyListState).currencies;
    currencies[index].checked = check;

    if (check) {
      group.currencies.add(currencies[index].code);
    } else {
      group.currencies.removeWhere((e) => e == currencies[index].code);
    }

    final allIsChecked = mainList.any((element) => element.checked == false);
    if (!allIsChecked) {
      checkAllCurrency = true;
    } else {
      checkAllCurrency = false;
    }

    value = SuccessCurrencyListState(currencies);
  }

  void checkAll({required bool check}) {
    for (final element in mainList) {
      element.checked = check;
    }
    if (check) {
      group.currencies
        ..clear()
        ..addAll(mainList.map((e) => e.code).toList());
    } else {
      group.currencies.clear();
    }

    checkAllCurrency = check;
    value = SuccessCurrencyListState(mainList);
  }
}
