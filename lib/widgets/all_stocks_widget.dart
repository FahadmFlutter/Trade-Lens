import 'package:flutter/material.dart';

import '../models/stock.dart';
import '../services/stock_service.dart';

class AllStocksWidget extends StatelessWidget {
  final StockService _stockService = StockService();

  AllStocksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Stock>>(
      future: _stockService.getAllStocks(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final watchlist = _stockService.getWatchlist();
        final otherStocks = snapshot.data!
            .where((stock) => !watchlist.contains(stock))
            .toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Other Stocks',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: otherStocks.length,
                itemBuilder: (context, index) {
                  final stock = otherStocks[index];
                  return ListTile(
                    title: Text(stock.symbol),
                    subtitle: Text(stock.name),
                    trailing: Text(
                      '\$${stock.currentPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      if (_stockService.addToWatchlist(stock)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Stock added to watchlist'),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Watchlist is full'),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}