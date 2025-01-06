import 'package:flutter/material.dart';

import '../../services/stock_service.dart';
import '../../widgets/stock/stock_search.dart';
import '../other_stocks/other_stocks_screen.dart';
import '../watchlist/watchlist_screen.dart';

class HomeScreen extends StatelessWidget {
  final StockService stockService = StockService();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock Trading'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSearch(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            WatchlistScreen(stockService: stockService),
            OtherStocksScreen(stockService: stockService),
          ],
        ),
      ),
    );
  }

  void _showSearch(BuildContext context) {
    showSearch(
      context: context,
      delegate: StockSearchDelegate(stockService: stockService),
    );
  }
}