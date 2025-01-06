import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../models/stock.dart';

class StockChart extends StatelessWidget {
  final Stock stock;

  const StockChart({super.key, required this.stock});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: true,),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: stock.historicalData.asMap().entries.map((entry) {
              return FlSpot(entry.key.toDouble(), entry.value);
            }).toList(),
            isCurved: false,
            color: Colors.blue,
            barWidth: 1,
            dotData: const FlDotData(show: false),
          ),
        ],
      ),
    );
  }
}