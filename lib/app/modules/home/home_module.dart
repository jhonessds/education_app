import 'package:demo/app/modules/home/presenter/views/home_view.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child(
      Modular.initialRoute,
      child: (_) => const HomeView(),
    );
  }
}
