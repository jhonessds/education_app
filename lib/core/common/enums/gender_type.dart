import 'package:demo/core/common/actions/app_actions.dart';

enum GenderType {
  male('MALE', 0),
  female('FEMALE', 10),
  none('NONE', 20);

  const GenderType(this.name, this.value);

  factory GenderType.fromString(String value) {
    switch (value) {
      case 'MALE':
        return GenderType.male;
      case 'FEMALE':
        return GenderType.female;
      default:
        return GenderType.male;
    }
  }
  String get translated {
    switch (this) {
      case GenderType.male:
        return translation().male;
      case GenderType.female:
        return translation().female;
      case GenderType.none:
        return translation().male;
    }
  }

  final String name;
  final int value;

  @override
  String toString() => name;
}
