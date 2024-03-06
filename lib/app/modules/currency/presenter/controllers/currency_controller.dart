import 'package:demo/app/modules/currency/data/models/currency_history_model.dart';
import 'package:demo/app/modules/currency/domain/entities/currency_simple.dart';
import 'package:demo/app/modules/currency/domain/entities/quotation.dart';
import 'package:demo/app/modules/currency/domain/usecases/delete_all_history.dart';
import 'package:demo/app/modules/currency/domain/usecases/get_local_quotation.dart';
import 'package:demo/app/modules/currency/domain/usecases/get_web_quotation.dart';
import 'package:demo/app/modules/currency/domain/usecases/save_history.dart';
import 'package:demo/app/modules/currency/domain/usecases/save_quotation.dart';
import 'package:demo/app/modules/currency/presenter/controllers/store/currency_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:objectbox/objectbox.dart';

class CurrencyController {
  CurrencyController({
    required GetLocalQuotation getLocalQuotation,
    required GetWebQuotation getWebQuotation,
    required SaveQuotation saveQuotation,
    required SaveHistory saveHistory,
    required DeleteAllHistory deleteAllHistory,
  })  : _getLocalQuotation = getLocalQuotation,
        _getWebQuotation = getWebQuotation,
        _saveQuotation = saveQuotation,
        _saveHistory = saveHistory,
        _deleteAllHistory = deleteAllHistory;

  final GetLocalQuotation _getLocalQuotation;
  final GetWebQuotation _getWebQuotation;
  final SaveQuotation _saveQuotation;
  final SaveHistory _saveHistory;
  final DeleteAllHistory _deleteAllHistory;

  String errorMessage = '';
  late Quotation quotation;

  double currency = 0;

  Future<bool> getLocalQuotation() async {
    final result = await _getLocalQuotation();

    return result.fold((l) {
      errorMessage = l.statusCode.translated;
      return false;
    }, (r) {
      if (r != null) quotation = r;

      return r != null;
    });
  }

  Future<bool> getWebQuotation() async {
    final result = await _getWebQuotation();

    return result.fold((l) {
      errorMessage = l.statusCode.translated;
      return false;
    }, (r) {
      quotation = r;
      return true;
    });
  }

  Future<bool> saveQuotation({required Quotation quotation}) async {
    final result = await _saveQuotation(quotation);

    return result.fold((l) {
      errorMessage = l.statusCode.translated;
      return false;
    }, (r) {
      return true;
    });
  }

  Future<bool> saveHistory() async {
    final store = Modular.get<CurrencyListStore>();
    for (final item in store.group.currencies) {
      item.id = 0;
    }

    final history = CurrencyHistoryModel(
      date: DateTime.now(),
      isGroup: store.group.currencies.length > 1,
      groupName: store.group.currencies.length > 1 ? store.group.name : null,
      amount: currency,
      currencies: ToMany<CurrencySimple>(items: store.group.currencies),
      currencyOrigin: store.currencyLeft!,
    );

    final result = await _saveHistory(history);

    return result.fold((l) {
      errorMessage = l.statusCode.translated;
      return false;
    }, (r) {
      return true;
    });
  }

  Future<bool> deleteAllHistory() async {
    final result = await _deleteAllHistory();

    return result.fold((l) {
      errorMessage = l.statusCode.translated;
      return false;
    }, (r) {
      return true;
    });
  }
}
