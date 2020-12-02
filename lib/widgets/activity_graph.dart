import 'package:cleaner_app/consts.dart';
import 'package:cleaner_app/services/providers/providers.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//This class is unused. Needed to be erased later
class ActivityGraph extends StatefulWidget {
  @override
  _ActivityGraphState createState() => _ActivityGraphState();
}

class _ActivityGraphState extends State<ActivityGraph> {
  List<Color> gradientColors = [
    Consts.primaryBlue,
  ];

  @override
  Widget build(BuildContext context) {
    final singleRoomProvider =
        Provider.of<SingleRoomProvider>(context, listen: false);
    final activityGraphData = singleRoomProvider.activityGraphData;
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
        color: Consts.activityBackground,
      ),
      child: activityGraphData == null
          ? Stack(
              fit: StackFit.expand,
              alignment: Alignment.center,
              children: [
                ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Consts.grey4,
                    BlendMode.modulate,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image(
                      fit: BoxFit.cover,
                      image: AssetImage(
                          'assets/images/no_heatmap_placeholder.jpg'),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 48,
                  child: Text(
                    'No activity graph available',
                    style: TextStyle(
                      fontSize: 30,
                      color: Consts.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            )
          : Padding(
              padding: const EdgeInsets.only(
                  right: 48, left: 16, top: 32, bottom: 16),
              child: Container(
                child: LineChart(
                  mainData(),
                ),
              ),
            ),
    );
  }

  LineChartData mainData() {
    final singleRoomProvider = Provider.of<SingleRoomProvider>(context);
    final activityGraphData = singleRoomProvider.activityGraphData;
    final data = activityGraphData['activityData'] as List<int>;
    List<FlSpot> flSpots = [];
    for (int i = 0; i < data.length; i++) {
      flSpots.add(FlSpot((i * 20).toDouble(), data[i].toDouble()));
    }

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        drawHorizontalLine: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          interval: 4,
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
            color: Consts.primaryBlue,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          getTitles: (value) {
            if (value == activityGraphData['minX'])
              return activityGraphData['xTitles'][0];
            else if (value == activityGraphData['maxX'] ~/ 5 * 1) {
              return activityGraphData['xTitles'][1];
            } else if (value == activityGraphData['maxX'] ~/ 5 * 2)
              return activityGraphData['xTitles'][2];
            else if (value == activityGraphData['maxX'] ~/ 5 * 3)
              return activityGraphData['xTitles'][3];
            else if (value == activityGraphData['maxX'] ~/ 5 * 4)
              return activityGraphData['xTitles'][4];
            else if (value == activityGraphData['maxX'])
              return activityGraphData['xTitles'][5];
            return '';
          },
          margin: 16,
        ),
        leftTitles: SideTitles(
          interval: 1,
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Consts.primaryBlue,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            if (value == activityGraphData['minY'])
              return activityGraphData['yTitles'][0];
            else if (value == activityGraphData['maxY'] / 5 * 1)
              return activityGraphData['yTitles'][1];
            else if (value == activityGraphData['maxY'] / 5 * 2)
              return activityGraphData['yTitles'][2];
            else if (value == activityGraphData['maxY'] / 5 * 3)
              return activityGraphData['yTitles'][3];
            else if (value == activityGraphData['maxY'] / 5 * 4)
              return activityGraphData['yTitles'][4];
            else if (value == activityGraphData['maxY'])
              return activityGraphData['yTitles'][5];
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Color(0xff37434d), width: 1),
      ),
      minX: activityGraphData['minX'].toDouble(),
      maxX: activityGraphData['maxX'].toDouble(),
      minY: activityGraphData['minY'].toDouble(),
      maxY: activityGraphData['maxY'].toDouble(),
      lineBarsData: [
        LineChartBarData(
          preventCurveOverShooting: true,
          spots: flSpots,
          isCurved: true,
          colors: gradientColors,
          barWidth: 1,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
              show: true,
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList()),
        ),
      ],
    );
  }
}
