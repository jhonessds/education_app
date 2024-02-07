import 'package:demo/app/modules/currency/data/models/currency_price_model.dart';
import 'package:demo/app/modules/currency/data/models/quotation_model.dart';
import 'package:demo/app/modules/currency/domain/entities/currency.dart';
import 'package:demo/app/modules/currency/domain/entities/quotation.dart';
import 'package:demo/core/abstraction/logger.dart';
import 'package:demo/core/errors/server_failure.dart';
import 'package:demo/core/services/database/box_repository.dart';
import 'package:demo/core/services/web/web_service.dart';
import 'package:demo/core/utils/status_code.dart';
import 'package:objectbox/objectbox.dart';

abstract class CurrencyDataSource {
  Future<QuotationModel> getCotation();
  Future<void> saveCotation();
}

class CurrencyDataSourceImpl implements CurrencyDataSource {
  CurrencyDataSourceImpl({
    required WebService webService,
    required ObjectBoxRepository objectBoxRepository,
  })  : _webService = webService,
        _boxRepository = objectBoxRepository;

  final WebService _webService;
  final ObjectBoxRepository _boxRepository;

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
            currrencies: ToMany<Currency>(items: currencies.getProperties()),
            date: DateTime.now(),
          );

          return quotation.toMap();
        },
      );
      if (result.success) {
        final quotation = QuotationModel.fromMap(result.data);
        final saved = await _boxRepository.create<Quotation>(value: quotation);

        if (saved) {
          return quotation;
        } else {
          throw const ServerFailure(statusCode: StatusCode.cache);
        }
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
