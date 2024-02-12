class CurrencySelectable {
  CurrencySelectable({
    required this.code,
    required this.name,
    this.value = 0,
    this.checked = false,
  });

  final String code;
  final String name;
  double value;
  bool checked;
}
