import 'package:flutter/material.dart';

import '../../services/stock_service.dart';
import '../../widgets/watchlist/watchlist_card.dart';

class WatchlistScreen extends StatelessWidget {
  final StockService stockService;

  const WatchlistScreen({super.key, required this.stockService});

  @override
  Widget build(BuildContext context) {
    final watchlist = stockService.getWatchlist();

    return ListView.builder(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      itemCount: watchlist.length,
      itemBuilder: (context, index) {
        return WatchlistCard(stock: watchlist[index]);
      },
    );
  }
}