import 'package:demo/app/modules/currency/domain/entities/quotation.dart';
import 'package:demo/app/modules/currency/domain/repos/currency_repository.dart';
import 'package:demo/core/abstraction/usecase.dart';
import 'package:demo/core/utils/typedefs.dart';

class SaveQuotation extends UsecaseWithParam<void, Quotation> {
  SaveQuotation({required this.repository});

  final CurrencyRepository repository;

  @override
  ResultFuture<void> call(Quotation params) async =>
      repository.saveQuotation(quotation: params);
}
