import 'package:education_app/core/common/models/environment_model.dart';

enum Flavor { dev, prod }

class FlavorConfig {
  factory FlavorConfig({
    required Flavor flavor,
    required EnvironmentModel env,
  }) {
    _instance ??= FlavorConfig._internal(
      flavor,
      flavor.toString().replaceAll('Flavor.', ''),
      env,
    );

    return _instance!;
  }

  FlavorConfig._internal(this.flavor, this.name, this.env);
  final Flavor flavor;
  final String name;
  final EnvironmentModel env;

  static FlavorConfig? _instance;

  static FlavorConfig get instance {
    return _instance!;
  }

  static bool get isProduction => _instance?.flavor == Flavor.prod;
  static bool get isDev => _instance?.flavor == Flavor.dev;
}
