import 'package:flutter/material.dart';

import '../../models/stock.dart';
import '../../utils/number_formatter.dart';

class StockListItem extends StatelessWidget {
  final Stock stock;
  final VoidCallback? onTap;
  final bool isSelected;

  const StockListItem({
    super.key,
    required this.stock,
    this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(stock.symbol),
      subtitle: Text(stock.name),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            NumberFormatter.formatPrice(stock.currentPrice),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          if (isSelected)
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Icon(Icons.check_circle, color: Colors.green),
            ),
        ],
      ),
      onTap: onTap,
    );
  }
}