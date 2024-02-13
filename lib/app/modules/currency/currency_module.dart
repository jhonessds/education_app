import 'package:demo/app/modules/currency/data/datasources/currency_datasource.dart';
import 'package:demo/app/modules/currency/data/repos/currency_repository_impl.dart';
import 'package:demo/app/modules/currency/domain/repos/currency_repository.dart';
import 'package:demo/app/modules/currency/domain/usecases/delete_all_history.dart';
import 'package:demo/app/modules/currency/domain/usecases/get_all_history.dart.dart';
import 'package:demo/app/modules/currency/domain/usecases/get_local_quotation.dart';
import 'package:demo/app/modules/currency/domain/usecases/get_web_quotation.dart';
import 'package:demo/app/modules/currency/domain/usecases/save_history.dart';
import 'package:demo/app/modules/currency/domain/usecases/save_quotation.dart';
import 'package:demo/app/modules/currency/presenter/controllers/currency_controller.dart';
import 'package:demo/app/modules/currency/presenter/controllers/store/history_store.dart';
import 'package:demo/app/modules/currency/presenter/views/currency_view.dart';
import 'package:demo/core/environments/flavors_config.dart';
import 'package:demo/core/services/database/box_repository.dart';
import 'package:demo/core/services/database/box_repository_impl.dart';
import 'package:demo/core/services/web/web_service.dart';
import 'package:demo/core/services/web/web_service_impl.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CurrencyModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i
      ..addLazySingleton<WebService>(
        () => WebServiceImpl(
          FlavorConfig.instance.env.currencyApiServer,
          isAuthenticated: false,
        ),
      )
      ..addLazySingleton<ObjectBoxRepository>(ObjectBoxRepositoryImpl.new)
      ..addLazySingleton<CurrencyDataSource>(CurrencyDataSourceImpl.new)
      ..addLazySingleton<CurrencyRepository>(CurrencyRepositoryImpl.new)
      ..addLazySingleton<GetLocalQuotation>(GetLocalQuotation.new)
      ..addLazySingleton<GetWebQuotation>(GetWebQuotation.new)
      ..addLazySingleton<SaveQuotation>(SaveQuotation.new)
      ..addLazySingleton<SaveHistory>(SaveHistory.new)
      ..addLazySingleton<GetAllHistory>(GetAllHistory.new)
      ..addLazySingleton<DeleteAllHistory>(DeleteAllHistory.new)
      ..addLazySingleton<HistoryListStore>(HistoryListStore.new)
      ..addLazySingleton<CurrencyController>(CurrencyController.new);
    super.exportedBinds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      Modular.initialRoute,
      child: (_) => const CurrencyView(),
    );
  }
}
