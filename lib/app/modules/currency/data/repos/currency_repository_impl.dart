import 'package:demo/app/modules/currency/data/datasources/currency_datasource.dart';
import 'package:demo/app/modules/currency/domain/entities/currency_history.dart';
import 'package:demo/app/modules/currency/domain/entities/quotation.dart';
import 'package:demo/app/modules/currency/domain/repos/currency_repository.dart';
import 'package:demo/core/abstraction/either.dart';
import 'package:demo/core/errors/cache_failure.dart';
import 'package:demo/core/errors/server_failure.dart';
import 'package:demo/core/utils/typedefs.dart';

class CurrencyRepositoryImpl implements CurrencyRepository {
  CurrencyRepositoryImpl(this._datasource);
  final CurrencyDataSource _datasource;
  @override
  ResultFuture<Quotation?> getLocalQuotation() async {
    try {
      final result = await _datasource.getLocalQuotation();
      return Right(result);
    } on CacheFailure catch (e) {
      return Left(e);
    }
  }

  @override
  ResultFuture<Quotation> getWebQuotation() async {
    try {
      final result = await _datasource.getWebQuotation();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(e);
    }
  }

  @override
  ResultFuture<void> saveQuotation({required Quotation quotation}) async {
    try {
      final result = await _datasource.saveQuotation(quotation: quotation);
      return Right(result);
    } on CacheFailure catch (e) {
      return Left(e);
    }
  }

  @override
  ResultFuture<void> deleteAllHistory() async {
    try {
      final result = await _datasource.deleteAllHistory();
      return Right(result);
    } on CacheFailure catch (e) {
      return Left(e);
    }
  }

  @override
  ResultFuture<List<CurrencyHistory>> getAllHistory() async {
    try {
      final result = await _datasource.getAllHistory();
      return Right(result);
    } on CacheFailure catch (e) {
      return Left(e);
    }
  }

  @override
  ResultFuture<void> saveHistory({required CurrencyHistory model}) async {
    try {
      final result = await _datasource.saveHistory(model: model);
      return Right(result);
    } on CacheFailure catch (e) {
      return Left(e);
    }
  }
}
