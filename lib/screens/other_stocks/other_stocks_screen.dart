import 'package:flutter/material.dart';

import '../../services/stock_service.dart';
import '../../widgets/stock/stock_list_item.dart';

class OtherStocksScreen extends StatelessWidget {
  final StockService stockService;

  const OtherStocksScreen({super.key, required this.stockService});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: stockService.getAllStocks(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final watchlist = stockService.getWatchlist();
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
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: otherStocks.length,
              itemBuilder: (context, index) {
                final stock = otherStocks[index];
                return StockListItem(
                  stock: stock,
                  onTap: () => _handleStockSelection(context, stock),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _handleStockSelection(BuildContext context, stock) {
    if (stockService.addToWatchlist(stock)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Stock added to watchlist')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Watchlist is full')),
      );
    }
  }
}