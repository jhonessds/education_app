import 'package:demo/app/modules/currency/data/datasources/currency_datasource.dart';
import 'package:demo/app/modules/currency/presenter/views/currency_view.dart';
import 'package:demo/core/environments/flavors_config.dart';
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
      ..addLazySingleton<CurrencyDataSource>(CurrencyDataSourceImpl.new);
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
