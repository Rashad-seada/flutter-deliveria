import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartData extends StatelessWidget {
  const ChartData({super.key, this.data});
  final List<int>? data;

  @override
  Widget build(BuildContext context) {
    // If data is provided, map it to FlSpot, else use default spots
    List<FlSpot> spots;
    if (data != null && data!.isNotEmpty) {
      // Map each int to FlSpot, x = index, y = value as double
      spots = List<FlSpot>.generate(
        data!.length,
        (i) => FlSpot(i.toDouble(), data![i].toDouble()),
      );
    } else {
      spots = const [
        FlSpot(0, 5.5),
        FlSpot(.5, 5),
        FlSpot(1, 4.5),
        FlSpot(1.5, 5.5),
        FlSpot(2, 4),
        FlSpot(2.5, 3),
        FlSpot(3, 4),
        FlSpot(3.5, 3),
        FlSpot(4, 6),
        FlSpot(4.4, 2),
        FlSpot(5, 5),
        FlSpot(5.5, 4.3),
        FlSpot(6, 5),
        FlSpot(6.5, 4.8),
      ];
    }

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: LineChart(
          LineChartData(
            gridData: const FlGridData(show: false),
            titlesData: const FlTitlesData(show: false),
            borderData: FlBorderData(show: false),
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: true,
                curveSmoothness: 0.4,
                color: const Color.fromRGBO(134, 134, 134, 1),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.center,
                    colors: [
                      Color.fromRGBO(245, 240, 240, 1),
                      Color.fromRGBO(245, 240, 240, 0),
                    ],
                  ),
                ),
                barWidth: 3,
                dotData: const FlDotData(show: false),
              ),
            ],
            minX: 0,
            maxX: 6,
            minY: 0,
            maxY: 5.5,
          ),
        ),
      ),
    );
  }
}
