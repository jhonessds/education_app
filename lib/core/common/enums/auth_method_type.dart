enum AuthMethodType {
  anonymous('ANONYMOUS', 0),
  email('EMAIL', 1),
  github('GITHUB', 2),
  facebook('FACEBOOK', 3),
  apple('APPLE', 4),
  google('GOOGLE', 5);

  const AuthMethodType(this.name, this.value);

  @override
  String toString() => name;

  // ignore: sort_constructors_first
  factory AuthMethodType.fromString(String value) {
    switch (value) {
      case 'GOOGLE':
        return AuthMethodType.google;
      case 'GITHUB':
        return AuthMethodType.github;
      case 'FACEBOOK':
        return AuthMethodType.facebook;
      case 'APPLE':
        return AuthMethodType.apple;
      case 'EMAIL':
        return AuthMethodType.email;
      default:
        return AuthMethodType.anonymous;
    }
  }

  final String name;
  final int value;
}
