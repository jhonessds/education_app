import 'package:demo/app/modules/currency/presenter/views/currency_view.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CurrencyModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child(
      Modular.initialRoute,
      child: (_) => const CurrencyView(),
    );
  }
}
