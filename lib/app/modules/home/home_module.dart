import 'package:demo/app/modules/auth/auth_module.dart';
import 'package:demo/app/modules/currency/currency_module.dart';
import 'package:demo/app/modules/home/presenter/views/home_view.dart';
import 'package:demo/app/modules/profile/profile_module.dart';
import 'package:demo/app/modules/settings/settings_module.dart';
import 'package:demo/core/utils/core_utils.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  List<Module> get imports => [
        ProfileModule(),
        AuthModule(),
        CurrencyModule(),
      ];

  @override
  void routes(RouteManager r) {
    r
      ..child(
        Modular.initialRoute,
        child: (_) => const HomeView(),
      )
      ..module(
        '/settings',
        module: SettingsModule(),
        customTransition: CoreUtils.customTransition(),
      )
      ..module(
        '/auth',
        module: AuthModule(),
        customTransition: CoreUtils.customTransition(),
      )
      ..module(
        '/currency',
        module: CurrencyModule(),
        customTransition: CoreUtils.customTransition(),
      )
      ..module(
        '/profile',
        module: ProfileModule(),
        customTransition: CoreUtils.customTransition(),
      );
  }
}
