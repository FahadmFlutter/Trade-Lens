class NumberFormatter {
  static String formatPrice(double price) {
    return '\$${price.toStringAsFixed(2)}';
  }

  static String formatPercentage(double percentage) {
    return '${percentage.toStringAsFixed(2)}%';
  }
}