import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:habit_project/screens/user/sub_pages/analysis_screen/bar_data.dart';

class MybarGraph extends StatelessWidget {
  const MybarGraph({super.key, required this.weeklySummary});
  final List weeklySummary;
  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
        monday: weeklySummary[0],
        tuesday: weeklySummary[1],
        wednesday: weeklySummary[2],
        thursday: weeklySummary[3],
        friday: weeklySummary[4],
        saturday: weeklySummary[5],
        sunday: weeklySummary[6]);
    myBarData.initializeBarData();
    return BarChart(
      BarChartData(
        maxY: 100,
        minY: 0,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: const FlTitlesData(
          show: true,
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles:
                SideTitles(showTitles: true, getTitlesWidget: getBottomTitles),
          ),
        ),
        barGroups: myBarData.barData
            .map(
              (data) => BarChartGroupData(
                x: data.x,
                barRods: [
                  BarChartRodData(
                    toY: data.y,
                    color: Colors.yellow,
                    width: 25,
                    borderRadius: BorderRadius.circular(4),
                    backDrawRodData: BackgroundBarChartRodData(
                        show: true, toY: 100, color: Colors.yellow.shade100),  
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}

Widget getBottomTitles(double value, TitleMeta meta) {
  const style =
      TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14);
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text(
        'M',
        style: style,
      );
      break;
    case 1:
      text = const Text(
        'T',
        style: style,
      );
      break;
    case 2:
      text = const Text(
        'W',
        style: style,
      );
      break;
    case 3:
      text = const Text(
        'T',
        style: style,
      );
      break;
    case 4:
      text = const Text(
        'F',
        style: style,
      );
      break;
    case 5:
      text = const Text(
        'S',
        style: style,
      );
      break;
    case 6:
      text = const Text(
        'S',
        style: style,
      );
      break;

    default:
      text = const Text(
        '',
        style: style, 
      );
      break;
  }
  return SideTitleWidget(axisSide: meta.axisSide, child: text);
}
