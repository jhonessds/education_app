import 'package:demo/app/modules/currency/data/models/currency_price_model.dart';
import 'package:demo/app/modules/currency/data/models/quotation_model.dart';
import 'package:demo/app/modules/currency/domain/entities/currency.dart';
import 'package:demo/app/modules/currency/domain/entities/quotation.dart';
import 'package:demo/core/errors/cache_failure.dart';
import 'package:demo/core/errors/server_failure.dart';
import 'package:demo/core/services/database/box_repository.dart';
import 'package:demo/core/services/database/objectbox.g.dart';
import 'package:demo/core/services/web/web_service.dart';

abstract class CurrencyDataSource {
  Future<QuotationModel> getWebQuotation();
  Future<Quotation?> getLocalQuotation();
  Future<void> saveQuotation({required Quotation quotation});
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
  Future<QuotationModel> getWebQuotation() async {
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
        await saveQuotation(quotation: quotation);
        return quotation;
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
  Future<Quotation?> getLocalQuotation() async {
    try {
      final result = await _boxRepository.query<Quotation>(
        Quotation_.date.lessThan(
          DateTime.now()
              .subtract(const Duration(hours: 24))
              .millisecondsSinceEpoch,
        ),
      );
      if (result.isNotEmpty) return result.first;

      return null;
    } catch (e) {
      throw CacheFailure(
        message: e.toString(),
      );
    }
  }

  @override
  Future<void> saveQuotation({required Quotation quotation}) async {
    try {
      final saved = await _boxRepository.create<Quotation>(value: quotation);

      if (!saved) {
        throw const CacheFailure();
      }
    } on CacheFailure {
      rethrow;
    } catch (e) {
      throw CacheFailure(
        message: e.toString(),
      );
    }
  }
}
