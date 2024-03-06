import 'package:demo/app/modules/currency/data/datasources/currencies.dart';
import 'package:demo/app/modules/currency/data/models/currency_group_model.dart';
import 'package:demo/app/modules/currency/data/models/currency_local_model.dart';
import 'package:demo/app/modules/currency/data/models/currency_simple_model.dart';
import 'package:demo/app/modules/currency/domain/entities/currency_simple.dart';
import 'package:demo/app/modules/currency/presenter/controllers/currency_controller.dart';
import 'package:demo/app/modules/currency/presenter/controllers/state/currency_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:objectbox/objectbox.dart';

class CurrencyListStore extends ValueNotifier<CurrencyListState> {
  CurrencyListStore() : super(SuccessCurrencyListState([]));

  bool checkAllCurrency = false;
  String? currencyLeft;
  List<CurrencyLocalModel> mainList = <CurrencyLocalModel>[];
  CurrencyGroupModel group = CurrencyGroupModel(
    name: 'GRP',
    currencies: ToMany<CurrencySimple>(),
  );

  void setCurrencyLeft(String value) {
    currencyLeft = value;
    notifyListeners();
  }

  Future<void> getAll() async {
    value = LoadingCurrencyState();
    final result = currencies.map(CurrencyLocalModel.fromMap).toList();
    mainList.clear();
    mainList = result;
    for (final item in group.currencies) {
      final index = mainList.indexWhere((element) => element.code == item.code);
      mainList[index].checked = true;
    }
    value = SuccessCurrencyListState(mainList);
  }

  void convert(double currency) {
    final currencyCtrl = Modular.get<CurrencyController>();
    final buy = currencyCtrl.quotation.currencies
        .where((e) => e.code == currencyLeft)
        .first
        .buy;
    for (final item in group.currencies) {
      final val = buy * currency;
      final rbuy = currencyCtrl.quotation.currencies
          .where((e) => e.code == item.code)
          .first
          .buy;
      item.conversion = currency == 0 ? '0.0' : (val / rbuy).toStringAsFixed(2);
    }
    notifyListeners();
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
    final code = currencies[index].code;
    debugPrint(code);

    if (check) {
      group.currencies.add(CurrencySimpleModel(code: code));
    } else {
      // necessario pois deve ter algum erro com lista no object_box
      final tempList = group.currencies.toList()
        ..removeWhere((e) => e.code == code);
      group.currencies.clear();
      group.currencies.addAll(ToMany<CurrencySimple>(items: tempList));
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
        ..addAll(
          mainList.map((e) => CurrencySimpleModel(code: e.code)).toList(),
        );
    } else {
      group.currencies.clear();
    }

    checkAllCurrency = check;
    value = SuccessCurrencyListState(mainList);
  }
}
