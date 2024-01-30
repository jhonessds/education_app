extension StringExtension on String? {
  String capitalize() {
    try {
      return '${this?[0].toUpperCase()}${this?.substring(1)}';
    } catch (e) {
      return this ?? '';
    }
  }

  bool get isNullOrEmpty => this == null || this == '';
}
