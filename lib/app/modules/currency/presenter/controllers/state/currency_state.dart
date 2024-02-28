import 'package:demo/app/modules/currency/data/models/currency_local_model.dart';

abstract class CurrencyListState {}

class LoadingCurrencyState extends CurrencyListState {}

class SuccessCurrencyListState extends CurrencyListState {
  SuccessCurrencyListState(this.currencies);
  final List<CurrencyLocalModel> currencies;
}
