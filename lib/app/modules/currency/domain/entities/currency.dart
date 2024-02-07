abstract class Currency {
  Currency({
    required this.code,
    required this.name,
    required this.buy,
    required this.variation,
    this.sell,
  });

  final String code;
  final String name;
  final double buy;
  final double? sell;
  final double variation;

  @override
  String toString() {
    return 'Currency(code: $code, name: $name, buy: $buy, sell: $sell,'
        ' variation: $variation)';
  }
}
