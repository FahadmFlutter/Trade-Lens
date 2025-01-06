import 'package:flutter/material.dart';
import 'package:trade_lens/widgets/stock_chart.dart';

import '../services/stock_service.dart';

class WatchlistWidget extends StatefulWidget {
  const WatchlistWidget({super.key});

  @override
  State<WatchlistWidget> createState() => _WatchlistWidgetState();
}

class _WatchlistWidgetState extends State<WatchlistWidget> {
  final StockService _stockService = StockService();

  @override
  Widget build(BuildContext context) {
    final watchlist = _stockService.getWatchlist();

    return ListView.builder(
      shrinkWrap: true,
      itemCount: watchlist.length,
      itemBuilder: (context, index) {
        final stock = watchlist[index];
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListTile(
                title: Text(stock.symbol),
                subtitle: Text(stock.name),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '\$${stock.currentPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '${stock.percentageChange.toStringAsFixed(2)}%',
                      style: TextStyle(
                        color: stock.percentageChange >= 0
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 200,
                child: StockChart(stock: stock),
              ),
            ],
          ),
        );
      },
    );
  }
}