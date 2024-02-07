import 'package:demo/app/modules/currency/data/models/currency_price_model.dart';
import 'package:demo/app/modules/currency/data/models/quotation_model.dart';
import 'package:demo/core/errors/server_failure.dart';
import 'package:demo/core/services/web/web_service.dart';

abstract class CurrencyDataSource {
  Future<QuotationModel> getCotation();
  Future<void> saveCotation();
}

class CurrencyDataSourceImpl implements CurrencyDataSource {
  CurrencyDataSourceImpl({required WebService webService})
      : _webService = webService;

  final WebService _webService;

  @override
  Future<QuotationModel> getCotation() async {
    try {
      final result = await _webService.getModel<Map<String, dynamic>>(
        '',
        (data) {
          final currencies = CurrencyPriceModel.fromMap(
            // ignore: avoid_dynamic_calls
            (data as Map<String, dynamic>)['results']['currencies']
                as Map<String, dynamic>,
          );
          final quotation = QuotationModel(
            currrencies: currencies.getProperties(),
            date: DateTime.now(),
          );

          return quotation.toMap();
        },
      );
      if (result.success) {
        return QuotationModel.fromMap(result.data);
      } else {
        throw result.failure ?? const ServerFailure();
      }
    } on ServerFailure {
      rethrow;
    } catch (e) {
      throw ServerFailure(
        message: e.toString(),
      );
    }
  }

  @override
  Future<void> saveCotation() {
    throw UnimplementedError();
  }
}
