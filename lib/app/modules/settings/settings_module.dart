import 'package:demo/app/modules/settings/presenter/views/settings_view.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SettingsModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child(
      Modular.initialRoute,
      child: (_) => const SettingsView(),
    );
  }
}
