import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String apiKey = 'YOUR_ALPHA_VANTAGE_API_KEY';
  static const String baseUrl = 'https://www.alphavantage.co/query';

  Future<Map<String, dynamic>> fetchStockData(String symbol) async {
    final response = await http.get(
      Uri.parse(
        '$baseUrl?function=GLOBAL_QUOTE&symbol=$symbol&apikey=$apiKey',
      ),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load stock data');
    }
  }

  Future<List<double>> fetchHistoricalData(String symbol) async {
    final response = await http.get(
      Uri.parse(
        '$baseUrl?function=TIME_SERIES_DAILY&symbol=$symbol&apikey=$apiKey',
      ),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final timeSeriesData = data['Time Series (Daily)'] as Map<String, dynamic>;

      return timeSeriesData.values
          .take(10)
          .map((value) => double.parse(value['4. close']))
          .toList();
    } else {
      throw Exception('Failed to load historical data');
    }
  }
}