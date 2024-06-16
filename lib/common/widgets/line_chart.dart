import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF2697FF);
  static const Color contentColorDarkBlue = Color.fromARGB(255, 4, 7, 93);
}

class _LineChart extends StatelessWidget {
  final List<DateTime> dates;
  final List prices;

  const _LineChart({
    required this.dates,
    required this.prices,
  });

  @override
  Widget build(BuildContext context) {
    return LineChart(sampleData1);
  }

  LineChartData get sampleData1 => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: [
          LineChartBarData(
            isCurved: true,
            color: AppColors.primary,
            barWidth: 6,
            isStrokeCapRound: true,
            preventCurveOverShooting: true,
            dotData: const FlDotData(show: true),
            belowBarData: BarAreaData(show: false),
            spots: List.generate(dates.length, (index) {
              return FlSpot(index.toDouble(), prices[index].toDouble());
            }),
          ),
        ],
      );

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (touchedSpot) => Colors.blueGrey.withOpacity(0.8),
        ),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        // leftTitles: AxisTitles(
        //   sideTitles: leftTitles(),
        // ),
      );

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    return Text('${value.toStringAsFixed(1)}',
        style: style, textAlign: TextAlign.center);
  }
// In the expression (prices.reduce((a, b) => b > a ? b : a) - prices.reduce((a, b) => b < a ? b : a)), a and b are placeholders representing the elements of the list prices that are being compared during the reduction process.

// Let's break down the expression:

// prices.reduce((a, b) => b > a ? b : a): This part of the expression calculates the maximum value in the prices list. It iterates over each element of the prices list and compares it with the current accumulator value a. If the current element b is greater than the accumulator value a, it replaces a with b, effectively finding the maximum value in the list.

// prices.reduce((a, b) => b < a ? b : a): This part of the expression calculates the minimum value in the prices list. It iterates over each element of the prices list and compares it with the current accumulator value a. If the current element b is less than the accumulator value a, it replaces a with b, effectively finding the minimum value in the list.

// So, during the reduction process:

// a represents the accumulator value, which starts with the first element of the list and is updated as the reduction progresses.
// b represents the current element being compared with the accumulator.
// After the reduction process, a holds the maximum value in the list, and b holds the minimum value in the list. Then, the expression calculates the difference between the maximum and minimum values in the prices list.
  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: (prices.reduce((a, b) => b > a ? b : a) -
                prices.reduce((a, b) => b < a ? b : a)) /
            5,
        reservedSize: 55,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    int index = value.toInt();
    String text = '';

    if (index >= 0 && index < dates.length) {
      final date = dates[index];
      text = '${date.day} ${_getMonthAbbreviation(date.month)}';
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: Text(text, style: style),
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  String _getMonthAbbreviation(int month) {
    const monthAbbreviations = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return monthAbbreviations[month];
  }

  FlGridData get gridData => const FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom:
              BorderSide(color: AppColors.primary.withOpacity(0.2), width: 4),
          left: BorderSide(color: AppColors.primary.withOpacity(0.2), width: 4),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      );
}

class LineChartSample1 extends StatefulWidget {
  final List<DateTime> dates;
  final List prices;

  const LineChartSample1({
    required this.dates,
    required this.prices,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => LineChartSample1State();
}

class LineChartSample1State extends State<LineChartSample1> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.30,
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Lowest Price History',
                style: TextStyle(
                  color: AppColors.contentColorDarkBlue,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 37,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16, left: 6),
                  child: _LineChart(
                    dates: widget.dates,
                    prices: widget.prices,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
