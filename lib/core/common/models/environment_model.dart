class EnvironmentModel {
  EnvironmentModel({required this.production});

  factory EnvironmentModel.fromJson(Map<String, dynamic> json) {
    return EnvironmentModel(
      production: json['production'] as bool,
    );
  }
  final bool production;
}
