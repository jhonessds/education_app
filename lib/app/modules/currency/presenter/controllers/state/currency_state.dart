import 'package:demo/app/modules/currency/domain/entities/currency_local.dart';

abstract class CurrencyListState {}

class LoadingCurrencyState extends CurrencyListState {}

class SuccessCurrencyListState extends CurrencyListState {
  SuccessCurrencyListState(this.currencies);
  final List<CurrencyLocal> currencies;
}
