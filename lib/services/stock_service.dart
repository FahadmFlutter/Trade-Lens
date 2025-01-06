

import '../models/stock.dart';
import 'api/stock_api_sservice.dart';

class StockService {
  static final List<Stock> _watchlist = [];
  final StockApiService _apiService = StockApiService();

  Future<List<Stock>> getAllStocks() async {
    try {
      // Initially load stocks from assets, then update with live data
      final List<Stock> stocks = await _loadInitialStocks();
      await Future.wait(
          stocks.map((stock) => _updateStockData(stock))
      );
      return stocks;
    } catch (e) {
      print('Error loading stocks: $e');
      return [];
    }
  }

  List<Stock> getWatchlist() => _watchlist;

  bool addToWatchlist(Stock stock) {
    if (_watchlist.length >= 2) return false;
    if (!_watchlist.contains(stock)) {
      _watchlist.add(stock);
      _updateStockData(stock);
      return true;
    }
    return false;
  }

  bool removeFromWatchlist(Stock stock) {
    return _watchlist.remove(stock);
  }

  Future<void> _updateStockData(Stock stock) async {
    try {
      final stockData = await _apiService.fetchStockData(stock.symbol);
      final historicalData = await _apiService.fetchHistoricalData(stock.symbol);

      final globalQuote = stockData['Global Quote'];
      stock.currentPrice = double.parse(globalQuote['05. price']);
      stock.percentageChange = double.parse(globalQuote['10. change percent'].replaceAll('%', ''));
      stock.historicalData = historicalData;
    } catch (e) {
      print('Error updating stock data: $e');
    }
  }

  Future<void> refreshWatchlist() async {
    for (var stock in _watchlist) {
      await _updateStockData(stock);
    }
  }

  Future<List<Stock>> _loadInitialStocks() async {
    // This would typically load from your assets/stock_data.json
    // For now, returning a simple list
    return [
      Stock(
        symbol: "AAPL",
        name: "Apple Inc.",
        currentPrice: 150.25,
        percentageChange: 2.5,
        historicalData: [148.50, 149.20, 149.80, 150.10, 150.25],
      ),
      Stock(
        symbol: "GOOGL",
        name: "Alphabet Inc.",
        currentPrice: 2750.80,
        percentageChange: -0.8,
        historicalData: [2755.00, 2753.20, 2752.40, 2751.60, 2750.80],
      ),
      Stock(
        symbol: "MSFT",
        name: "Microsoft Corporation",
        currentPrice: 285.30,
        percentageChange: 1.2,
        historicalData: [282.10, 282.80, 283.50, 284.20, 285.30],
      ),
    ];
  }
}