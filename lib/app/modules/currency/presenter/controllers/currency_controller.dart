import 'package:demo/app/modules/currency/domain/entities/currency_history.dart';
import 'package:demo/app/modules/currency/domain/entities/quotation.dart';
import 'package:demo/app/modules/currency/domain/usecases/delete_all_history.dart';
import 'package:demo/app/modules/currency/domain/usecases/get_local_quotation.dart';
import 'package:demo/app/modules/currency/domain/usecases/get_web_quotation.dart';
import 'package:demo/app/modules/currency/domain/usecases/save_history.dart';
import 'package:demo/app/modules/currency/domain/usecases/save_quotation.dart';

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

  Future<bool> saveHistory({required CurrencyHistory history}) async {
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
