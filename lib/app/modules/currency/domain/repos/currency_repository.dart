import 'package:demo/app/modules/currency/domain/entities/currency_history.dart';
import 'package:demo/app/modules/currency/domain/entities/quotation.dart';
import 'package:demo/core/utils/typedefs.dart';

abstract class CurrencyRepository {
  ResultFuture<Quotation> getWebQuotation();
  ResultFuture<Quotation?> getLocalQuotation();
  ResultFuture<void> saveQuotation({required Quotation quotation});
  ResultFuture<void> saveHistory({required CurrencyHistory model});
  ResultFuture<List<CurrencyHistory>> getAllHistory();
  ResultFuture<void> deleteAllHistory();
}
