import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cleaner_app/consts.dart';
import 'package:cleaner_app/services/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SimpleLineChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final singleRoomProvider =
        Provider.of<SingleRoomProvider>(context, listen: false);

    return new charts.TimeSeriesChart(
      _createSampleData(singleRoomProvider),
      animate: false,
      dateTimeFactory: const charts.LocalDateTimeFactory(),
      primaryMeasureAxis: charts.NumericAxisSpec(
        showAxisLine: false,
        renderSpec: new charts.NoneRenderSpec(),
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
