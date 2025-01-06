import 'package:flutter/material.dart';
import 'package:trade_lens/widgets/stock/stock_list_item.dart';

import '../../models/stock.dart';
import '../../services/stock_service.dart';

class StockSearchDelegate extends SearchDelegate<Stock?> {
  final StockService stockService;

  StockSearchDelegate({required this.stockService});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<Stock>>(
      future: stockService.getAllStocks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final results = query.isEmpty
            ? []
            : snapshot.data!
            .where((stock) =>
        stock.symbol.toLowerCase().contains(query.toLowerCase()) ||
            stock.name.toLowerCase().contains(query.toLowerCase()))
            .toList();

        if (results.isEmpty) {
          return const Center(child: Text('No stocks found'));
        }

        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            final stock = results[index];
            return StockListItem(
              stock: stock,
              onTap: () => _handleStockSelection(context, stock),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const Center(
        child: Text(
          'Search for stocks by name or symbol',
          style: TextStyle(fontSize: 16.0),
        ),
      );
    }

    return buildResults(context);
  }

  void _handleStockSelection(BuildContext context, Stock stock) {
    final success = stockService.addToWatchlist(stock);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success
              ? '${stock.name} added to watchlist'
              : '${stock.name} is already in the watchlist or the list is full',
        ),
      ),
    );

    if (success) close(context, stock);
  }
}
