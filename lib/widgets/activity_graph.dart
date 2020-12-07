import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cleaner_app/consts.dart';
import 'package:cleaner_app/services/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActivityGraph extends StatelessWidget {
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
                right: 48,
                left: 16,
                top: 32,
                bottom: 16,
              ),
              child: Container(
                child: charts.TimeSeriesChart(
                  _createSampleData(singleRoomProvider),
                  animate: false,
                  domainAxis: new charts.DateTimeAxisSpec(
                    tickFormatterSpec: new charts.AutoDateTimeTickFormatterSpec(
                      minute: new charts.TimeFormatterSpec(
                        format: 'HH:mm',
                        transitionFormat: 'HH:mm',
                      ),
                      hour: charts.TimeFormatterSpec(
                        format: 'HH:mm',
                        transitionFormat: 'dd MMM HH:mm',
                      ),
                      day: new charts.TimeFormatterSpec(
                        format: 'dd',
                        transitionFormat: 'dd MMM',
                      ),
                    ),
                    renderSpec: charts.SmallTickRendererSpec(
                      labelAnchor: charts.TickLabelAnchor.centered,
                      labelStyle: new charts.TextStyleSpec(
                        lineHeight: 1.5,
                        fontSize: 12,
                        color: charts.ColorUtil.fromDartColor(
                          Consts.primaryBlue,
                        ),
                      ),
                      tickLengthPx: 8,
                      axisLineStyle: charts.LineStyleSpec(
                        color: charts.ColorUtil.fromDartColor(
                          Consts.primaryBlue,
                        ),
                      ),
                    ),
                  ),
                  primaryMeasureAxis: charts.NumericAxisSpec(
                    showAxisLine: false,
                    renderSpec: charts.NoneRenderSpec(),
                  ),
                ),
              ),
            ),
    );
  }

  /// Create one series with sample hard coded data.
  List<charts.Series<LinearActivity, DateTime>> _createSampleData(
      SingleRoomProvider singleRoomProvider) {
    final activityGraphData = singleRoomProvider.activityGraphData;
    final data = activityGraphData['activityData'] as List<int>;
    final startingTime = activityGraphData['lastCleaned'] as DateTime;

    List<LinearActivity> chartData = [];
    for (int i = 0; i < data.length; i++) {
      chartData.add(
          LinearActivity(startingTime.add(Duration(seconds: i * 20)), data[i]));
    }

    return [
      new charts.Series<LinearActivity, DateTime>(
        id: 'Activity',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Consts.primaryBlue),
        domainFn: (LinearActivity sales, _) => sales.time,
        measureFn: (LinearActivity sales, _) => sales.activity,
        data: chartData,
      )
    ];
  }
}

/// Sample linear data type.
class LinearActivity {
  final DateTime time;
  final int activity;
  LinearActivity(this.time, this.activity);
}
