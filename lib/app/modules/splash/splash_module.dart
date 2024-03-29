import 'package:demo/app/modules/splash/presenter/views/splash_view.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child(
      Modular.initialRoute,
      child: (_) => const SplashView(),
    );
  }
}
