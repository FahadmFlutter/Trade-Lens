class Stock {
  final String symbol;
  final String name;
  double currentPrice;
  double percentageChange;
  List<double> historicalData;

  Stock({
    required this.symbol,
    required this.name,
    required this.currentPrice,
    required this.percentageChange,
    required this.historicalData,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Stock &&
              runtimeType == other.runtimeType &&
              symbol == other.symbol;

  @override
  int get hashCode => symbol.hashCode;
}