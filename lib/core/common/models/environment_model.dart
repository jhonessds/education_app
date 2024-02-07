class EnvironmentModel {
  EnvironmentModel({required this.currencyApiServer, required this.production});

  factory EnvironmentModel.fromJson(Map<String, dynamic> json) {
    return EnvironmentModel(
      production: json['production'] as bool,
      currencyApiServer: json['currencyApiServer'] as String,
    );
  }

  final bool production;
  final String currencyApiServer;
}
