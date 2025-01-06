import 'package:flutter/material.dart';

import '../models/stock.dart';
import '../services/stock_service.dart';

class StockSearchDelegate extends SearchDelegate<Stock?> {
  final StockService _stockService = StockService();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<Stock>>(
      future: _stockService.getAllStocks(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final results = snapshot.data!
            .where((stock) =>
                stock.symbol.toLowerCase().contains(query.toLowerCase()) ||
                stock.name.toLowerCase().contains(query.toLowerCase()))
            .toList();

        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            final stock = results[index];
            return ListTile(
              title: Text(stock.symbol),
              subtitle: Text(stock.name),
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
                      content: Text('Watchlist is full or stock already added'),
                    ),
                  );
                }
                close(context, stock);
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }
}
