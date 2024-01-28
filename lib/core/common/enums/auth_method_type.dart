enum AuthMethodType {
  unknown('UNKNOWN', 0),
  email('EMAIL', 1),
  google('GOOGLE', 2);

  const AuthMethodType(this.name, this.value);

  @override
  String toString() => name;

  // ignore: sort_constructors_first
  factory AuthMethodType.fromString(String value) {
    switch (value) {
      case 'GOOGLE':
        return AuthMethodType.google;
      case 'EMAIL':
        return AuthMethodType.email;
      default:
        return AuthMethodType.unknown;
    }
  }

  final String name;
  final int value;
}
