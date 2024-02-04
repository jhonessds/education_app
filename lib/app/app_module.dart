import 'package:demo/app/modules/auth/auth_module.dart';
import 'package:demo/app/modules/auth/presenter/views/verify_email_view.dart';
import 'package:demo/app/modules/home/home_module.dart';
import 'package:demo/app/modules/profile/profile_module.dart';
import 'package:demo/app/modules/register/register_module.dart';
import 'package:demo/app/modules/splash/splash_module.dart';
import 'package:demo/core/common/models/environment_model.dart';
import 'package:demo/core/environments/flavors_config.dart';
import 'package:demo/core/utils/core_utils.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.add<EnvironmentModel>((i) => FlavorConfig.instance.env);
  }

  @override
  List<Module> get imports => [
        AuthModule(),
        RegisterModule(),
        ProfileModule(),
      ];

  @override
  void routes(RouteManager r) {
    r
      ..module(
        '/splash',
        module: SplashModule(),
        customTransition: CoreUtils.customTransition(),
      )
      ..module(
        '/auth',
        module: AuthModule(),
        customTransition: CoreUtils.customTransition(),
      )
      ..module(
        '/home',
        module: HomeModule(),
        customTransition: CoreUtils.customTransition(),
      )
      ..child('/verify-email', child: (_) => const VerifyEmailView());
  }
}
