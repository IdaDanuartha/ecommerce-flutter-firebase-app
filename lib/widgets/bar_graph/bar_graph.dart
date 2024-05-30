import 'package:MushMagic/themes.dart';
import 'package:MushMagic/widgets/bar_graph/bar_data.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MyBarGraph extends StatelessWidget {
  final List weeklyTransactions;

  const MyBarGraph({super.key, required this.weeklyTransactions});

  @override
  Widget build(BuildContext context) {
    // Initialize bar data
    BarData myBarData = BarData(
      sunAmount: weeklyTransactions[0], 
      monAmount: weeklyTransactions[1], 
      tueAmount: weeklyTransactions[2], 
      wedAmount: weeklyTransactions[3], 
      thuAmount: weeklyTransactions[4], 
      friAmount: weeklyTransactions[5], 
      satAmount: weeklyTransactions[6],
    );
    myBarData.initializeBarData();

    return BarChart(
      BarChartData(
        maxY: 100,
        minY: 0,
        titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          // bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        barGroups: myBarData.barData.map((data) => BarChartGroupData(
          x: data.x,
          barRods: [
            BarChartRodData(
              toY: data.y,
              color: primaryColor,
              width: 15,
              borderRadius: BorderRadius.circular(5),
              backDrawRodData: BackgroundBarChartRodData(
                show: true,
                toY: 100,
                color: Color.fromRGBO(108, 94, 207, .05),
              )
            ),
          ],
        )).toList()
      )
    );
  }
}