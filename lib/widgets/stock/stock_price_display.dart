import 'package:flutter/material.dart';

import '../../utils/number_formatter.dart';

class StockPriceDisplay extends StatelessWidget {
  final double price;
  final double percentageChange;

  const StockPriceDisplay({
    super.key,
    required this.price,
    required this.percentageChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          NumberFormatter.formatPrice(price),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          NumberFormatter.formatPercentage(percentageChange),
          style: TextStyle(
            color: percentageChange >= 0 ? Colors.green : Colors.red,
          ),
        ),
      ],
    );
  }
}