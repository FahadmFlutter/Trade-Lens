import 'package:flutter/material.dart';

import '../../models/stock.dart';
import '../../services/stock_service.dart';
import '../../widgets/stock/stock_list_item.dart';
import '../home/home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final StockService _stockService = StockService();
  final List<Stock> _selectedStocks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Your Stocks')),
      body: FutureBuilder<List<Stock>>(
        future: _stockService.getAllStocks(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final stock = snapshot.data![index];
              final bool isSelected = _selectedStocks.contains(stock);

              return StockListItem(
                stock: stock,
                isSelected: isSelected,
                onTap: () => _handleStockSelection(stock),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _selectedStocks.isEmpty ? null : _proceedToHome,
        label: const Text('Continue'),
        icon: const Icon(Icons.arrow_forward),
      ),
    );
  }

  void _handleStockSelection(Stock stock) {
    setState(() {
      if (_selectedStocks.contains(stock)) {
        _selectedStocks.remove(stock);
      } else if (_selectedStocks.length < 2) {
        _selectedStocks.add(stock);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('You can only select up to 2 stocks'),
          ),
        );
      }
    });
  }

  void _proceedToHome() {
    for (var stock in _selectedStocks) {
      _stockService.addToWatchlist(stock);
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }
}