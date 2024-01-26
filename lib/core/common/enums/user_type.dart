enum UserType {
  unknown('UNKNOWN', 0),
  anonymous('ANONYMOUS', 10),
  common('COMMON', 20),
  master('MASTER', 100);

  const UserType(this.name, this.value);

  factory UserType.fromString(String value) {
    switch (value) {
      case 'UNKNOWN':
        return UserType.unknown;
      case 'ANONYMOUS':
        return UserType.anonymous;
      case 'COMMON':
        return UserType.common;
      case 'MASTER':
        return UserType.master;
      default:
        return UserType.unknown;
    }
  }

  final String name;
  final int value;

  @override
  String toString() => name;

  String get translatedValue {
    switch (this) {
      case UserType.unknown:
        return 'unknown';
      case UserType.anonymous:
        return 'anonymous';
      case UserType.common:
        return 'common';
      case UserType.master:
        return 'Master';
    }
  }
}
