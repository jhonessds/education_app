import 'package:demo/core/common/actions/app_actions.dart';

enum UserType {
  anonymous('ANONYMOUS', 10),
  common('COMMON', 20),
  master('MASTER', 100);

  const UserType(this.name, this.value);

  factory UserType.fromString(String value) {
    switch (value) {
      case 'ANONYMOUS':
        return UserType.anonymous;
      case 'COMMON':
        return UserType.common;
      case 'MASTER':
        return UserType.master;
      default:
        return UserType.anonymous;
    }
  }

  final String name;
  final int value;

  @override
  String toString() => name;

  String get translated {
    switch (this) {
      case UserType.anonymous:
        return translation().anonymous;
      case UserType.common:
        return translation().common;
      case UserType.master:
        return 'Master';
    }
  }
}
