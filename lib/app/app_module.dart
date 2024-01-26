import 'package:demo/core/common/models/environment_model.dart';
import 'package:demo/core/environments/flavors_config.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.add<EnvironmentModel>((i) => FlavorConfig.instance.env);
  }
}
