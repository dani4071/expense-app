import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class myChart extends StatefulWidget {
  const myChart({super.key});

  @override
  State<myChart> createState() => _myChartState();
}

class _myChartState extends State<myChart> {
  @override
  Widget build(BuildContext context) {
    return BarChart(
      mainBarChat(),
    );
  }

  BarChartGroupData makeGroupData(int x, double y){
    return BarChartGroupData(
        x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          width: 15,
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
                Theme.of(context).colorScheme.tertiary,
              ],
              transform: const GradientRotation(pi / 1.02),
            ),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 5,
            color: Colors.grey
          )
        ),
      ]
    );
  }



  List<BarChartGroupData> showingGroups() => List.generate(8, (i){
    switch (i) {
      case 0:
        return makeGroupData(0, 2);
      case 1:
        return makeGroupData(1, 3);
      case 2:
        return makeGroupData(2, 2);
      case 3:
        return makeGroupData(3, 4.5);
      case 4:
        return makeGroupData(4, 3.8);
      case 5:
        return makeGroupData(5, 1.5);
      case 6:
        return makeGroupData(6, 4);
      case 7:
        return makeGroupData(7, 3.8);
      default:
        return throw Error();
    }
  });

  BarChartData mainBarChat() {
    return BarChartData(
        titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: getTiles,
                reservedSize: 38,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: leftTiles,
                reservedSize: 33,
              ),
            )
        ),
      borderData: FlBorderData(
        show: false
      ),
      gridData: const FlGridData(
        show: false
      ),
      barGroups: showingGroups(),

    );
  }

  Widget getTiles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      fontSize: 15,
    );
    Widget text;

    switch (value.toInt()) {
      case 0:
        text = const Text("01", style: style,);
        break;
      case 1:
        text = const Text("02", style: style,);
        break;
      case 2:
        text = const Text("03", style: style,);
        break;
      case 3:
        text = const Text("04", style: style,);
        break;
      case 4:
        text = const Text("05", style: style,);
        break;
      case 5:
        text = const Text("06", style: style,);
        break;
      case 6:
        text = const Text("07", style: style,);
        break;
      case 7:
        text = const Text("08", style: style,);
        break;
      default:
        text = const Text("", style: style,);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  Widget leftTiles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      fontSize: 15,
    );
    String text;

    if(value == 0) {
      text = '1k';
    } else if (value == 2) {
      text = '2k';
    } else if (value == 3) {
      text = '3k';
    } else if (value == 4) {
      text = '4k';
    } else if (value == 5) {
      text = '5k';
    } else {
      return Container();
    }

    // switch (value.toInt()) {
    //   case 0:
    //     text = const Text("01", style: style,);
    //     break;
    //   case 1:
    //     text = const Text("02", style: style,);
    //     break;
    //   case 2:
    //     text = const Text("03", style: style,);
    //     break;
    //   case 3:
    //     text = const Text("04", style: style,);
    //     break;
    //   case 4:
    //     text = const Text("05", style: style,);
    //     break;
    //   case 5:
    //     text = const Text("06", style: style,);
    //     break;
    //   default:
    //     text = const Text("", style: style,);
    //     break;
    // }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: Text(text, style: style,),
    );
  }
}