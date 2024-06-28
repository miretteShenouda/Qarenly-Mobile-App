import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppColors {
  static const Color primary = Color(0xFF2697FF);
  static const Color contentColorDarkBlue = Color.fromRGBO(0, 48, 73, 1.0);
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

  LineChartData get sampleData1 {
    if (prices.isEmpty) {
      return LineChartData(); // Return an empty chart data to avoid further processing.
    }

    final minY = prices.reduce((a, b) => a < b ? a : b).toDouble();
    final maxY = prices.reduce((a, b) => a > b ? a : b).toDouble();
    final range = maxY - minY;
    final interval =
        range == 0 ? 1.0 : range / 5; // Adjust the interval as needed
    return LineChartData(
      lineTouchData: lineTouchData1,
      gridData: gridData,
      titlesData: titlesData1(minY, maxY, interval),
      borderData: borderData,
      minY: minY,
      maxY: maxY,
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
  }

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (touchedSpot) =>
              const Color.fromARGB(255, 163, 174, 179).withOpacity(0.8),
        ),
      );

  FlTitlesData titlesData1(double minY, double maxY, double interval) =>
      FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(minY, maxY, interval),
        ),
      );

  SideTitles leftTitles(double minY, double maxY, double interval) =>
      SideTitles(
        showTitles: true,
        reservedSize: 60,
        getTitlesWidget: (value, meta) =>
            leftTitleWidgets(value, minY, maxY, interval),
        interval: interval,
      );

  Widget leftTitleWidgets(
      double value, double minY, double maxY, double interval) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
      color: AppColors.contentColorDarkBlue,
    );

    if (value == minY || value == maxY || ((value - minY) % interval == 0)) {
      return Text("${NumberFormat('#,###').format(value)}",

          // return Text('${value.toStringAsFixed(1)}k',
          style: style,
          textAlign: TextAlign.center);
    } else {
      return Container(); // Empty container for values not at the specified intervals
    }
  }

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
                    child: widget.prices.isNotEmpty
                        ? _LineChart(
                            dates: widget.dates,
                            prices: widget.prices,
                          )
                        : Center(
                            child: Text('No data available',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: AppColors.contentColorDarkBlue)))),
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
