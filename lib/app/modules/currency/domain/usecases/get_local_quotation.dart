import 'package:demo/app/modules/currency/domain/entities/quotation.dart';
import 'package:demo/app/modules/currency/domain/repos/currency_repository.dart';
import 'package:demo/core/abstraction/usecase.dart';
import 'package:demo/core/utils/typedefs.dart';

class GetLocalQuotation extends UsecaseWithoutParam<Quotation?> {
  GetLocalQuotation({required this.repository});

  final CurrencyRepository repository;

  @override
  ResultFuture<Quotation?> call() async => repository.getLocalQuotation();
}
