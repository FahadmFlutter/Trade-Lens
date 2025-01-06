import 'package:flutter/material.dart';

import '../../models/stock.dart';
import '../stock/stock_price_display.dart';
import '../stock_chart.dart';

class WatchlistCard extends StatelessWidget {
  final Stock stock;

  const WatchlistCard({super.key, required this.stock});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ListTile(
            title: Text(stock.symbol),
            subtitle: Text(stock.name),
            trailing: StockPriceDisplay(
              price: stock.currentPrice,
              percentageChange: stock.percentageChange,
            ),
          ),
          SizedBox(
            height: 100,
            child: StockChart(stock: stock),
          ),
        ],
      ),
    );
  }
}