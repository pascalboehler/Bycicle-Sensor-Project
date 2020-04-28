import 'package:flutter/material.dart';
import './BackgroundCollectingTask.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class MeasureDataPage extends StatefulWidget {
  @override
  _MeasureDataPageState createState() => _MeasureDataPageState();
}

class _MeasureDataPageState extends State<MeasureDataPage> {
    //Data to displayed in the pieChart, yet example Data
    double distance1 = 150;
    double distance2 = 200;
    double distance3 = 300;

    double maxDistance = 300; // Max Distance to get a static relationship in the chart, maybe it has to change

    Color distanceColor1 = Colors.green ;
    Color distanceColor2 = Colors.green ; //TODO: change color if to close
    Color distanceColor3 = Colors.green ;

    List<charts.Series<DistanceDataPie, String>> _seriesPieData;
    List<charts.Series<DistanceDataPie, String>> _seriesPieData2;
    List<charts.Series<DistanceDataPie, String>> _seriesPieData3;

    List<charts.Series<DistanceDataPie, String>> _generateObject(BackgroundCollectingTask bgTask, int sensorNum) {
      _seriesPieData =  List<charts.Series<DistanceDataPie, String>>();
      switch(sensorNum) {
        case 1:
          var pieData = [
            new DistanceDataPie('Distance1', bgTask != null && bgTask.dataList.length != 0 ? bgTask.dataList.last.distance1 : 0, distanceColor1),
            new DistanceDataPie(
                'rest', maxDistance - (bgTask != null && bgTask.dataList.length != 0 ? bgTask.dataList.last.distance1 : 0), Colors.transparent),
          ];
          break;
        case 2:
          var pieData = [
            new DistanceDataPie('Distance1', bgTask != null && bgTask.dataList.length != 0 ? bgTask.dataList.last.distance2 : 0, distanceColor1),
            new DistanceDataPie(
                'rest', maxDistance - (bgTask != null && bgTask.dataList.length != 0 ? bgTask.dataList.last.distance2 : 0), Colors.transparent),
          ];
          break;
        case 3:
          var pieData = [
            new DistanceDataPie('Distance1', bgTask != null && bgTask.dataList.length != 0 ? bgTask.dataList.last.distance3 : 0, distanceColor1),
            new DistanceDataPie(
                'rest', maxDistance - (bgTask != null && bgTask.dataList.length != 0 ? bgTask.dataList.last.distance3 : 0), Colors.transparent),
          ];
          break;
        default:
          print("THIS CANNOT HAPPEN IF YOU USE THE FUNCTION PROPERLY");
      }
      var pieData = [
        new DistanceDataPie('Distance1', bgTask != null && bgTask.dataList.length != 0 ? bgTask.dataList.last.distance1 : 0, distanceColor1),
        new DistanceDataPie(
            'rest', maxDistance - (bgTask != null && bgTask.dataList.length != 0 ? bgTask.dataList.last.distance1 : 0), Colors.transparent),
      ];
      _seriesPieData.add(
        charts.Series(
          data: pieData,
          domainFn: (DistanceDataPie task, _) => task.distance,
          measureFn: (DistanceDataPie task, _) => task.distancevalue,
          colorFn: (DistanceDataPie task, _) =>
              charts.ColorUtil.fromDartColor(task.colorvalue),
          id: 'distance-measure1',
          labelAccessorFn: (DistanceDataPie row, _) => '${row.distancevalue}',
        ),
      );
      return _seriesPieData;
    }

    _generateData() {
      var pieData = [
        new DistanceDataPie('Distance1', distance1, distanceColor1),
        new DistanceDataPie(
            'rest', maxDistance - distance1, Colors.transparent),
      ];
      _seriesPieData.add(
        charts.Series(
          data: pieData,
          domainFn: (DistanceDataPie task, _) => task.distance,
          measureFn: (DistanceDataPie task, _) => task.distancevalue,
          colorFn: (DistanceDataPie task, _) =>
              charts.ColorUtil.fromDartColor(task.colorvalue),
          id: 'distance-measure1',
          labelAccessorFn: (DistanceDataPie row, _) => '${row.distancevalue}',
        ),
      );
      var pieData2 = [
        new DistanceDataPie('Distance2', distance2, distanceColor2),
        new DistanceDataPie(
            'rest', maxDistance - distance2, Colors.transparent),
      ];
      _seriesPieData2.add(
        charts.Series(
          data: pieData2,
          domainFn: (DistanceDataPie task, _) => task.distance,
          measureFn: (DistanceDataPie task, _) => task.distancevalue,
          colorFn: (DistanceDataPie task, _) =>
              charts.ColorUtil.fromDartColor(task.colorvalue),
          id: 'distance-measure2',
          labelAccessorFn: (DistanceDataPie row, _) => '${row.distancevalue}',
        ),
      );
      var pieData3 = [
        new DistanceDataPie('Distance3', distance3, distanceColor3),
        new DistanceDataPie(
            'rest', maxDistance - distance3, Colors.transparent),
      ];
      _seriesPieData3.add(
        charts.Series(
          data: pieData3,
          domainFn: (DistanceDataPie task, _) => task.distance,
          measureFn: (DistanceDataPie task, _) => task.distancevalue,
          colorFn: (DistanceDataPie task, _) =>
              charts.ColorUtil.fromDartColor(task.colorvalue),
          id: 'distance-measure3',
          labelAccessorFn: (DistanceDataPie row, _) => '${row.distancevalue}',
        ),
      );
    }
  @override
  void initState(){
    super.initState();
    _seriesPieData =  List<charts.Series<DistanceDataPie, String>>();
    _seriesPieData2 = List<charts.Series<DistanceDataPie, String>>();
    _seriesPieData3 = List<charts.Series<DistanceDataPie, String>>();
    _generateData();
  }

    @override
    Widget build(BuildContext context) {
      final BackgroundCollectingTask bgTask =
      BackgroundCollectingTask.of(context, rebuildOnChange: true);

      return Scaffold(
      appBar: AppBar(
        title: Text("MeasureDataPage"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.pause),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          child: Center(
            child: Column(
                children: <Widget>[
                  Text('left'),
                  Text(
                      'Sensor 1: ${bgTask != null && bgTask.dataList.length != 0 ? bgTask.dataList.last.distance1 : "NULL"}'),
                  SizedBox(height: 1.0),
                  Expanded(
                    child: charts.PieChart(
                      _generateObject(bgTask, 1), // TODO: Manage colour (red, green)
                      animate: true,
                      animationDuration: Duration(seconds: 0), //TODO: test different animationDuration
                      defaultRenderer: new charts.ArcRendererConfig(
                          arcWidth: 50,
                          arcRendererDecorators: [
                            new charts.ArcLabelDecorator(
                                labelPosition: charts.ArcLabelPosition.inside
                            )
                          ]
                      ),
                    ),
                  ),
                  Text('right'),
                  Text(
                      'Sensor 2: ${bgTask != null && bgTask.dataList.length != 0 ? bgTask.dataList.last.distance2 : "NULL"}'),
                  SizedBox(height: 1.0),
                  Expanded(
                    child: charts.PieChart(
                      _generateObject(bgTask, 2), // TODO: Manage colour (red, green)
                      animate: true,
                      animationDuration: Duration(seconds: 0), //TODO: test different animationDuration
                      defaultRenderer: new charts.ArcRendererConfig(
                          arcWidth: 50,
                          arcRendererDecorators: [
                            new charts.ArcLabelDecorator(
                                labelPosition: charts.ArcLabelPosition.inside
                            ),
                          ],
                      ),
                    ),
                  ),
                  Text('behind'),
                  Text(
                      'Sensor 3: ${bgTask != null && bgTask.dataList.length != 0 ? bgTask.dataList.last.distance3 : "NULL"}'),
                  SizedBox(height: 1.0),
                  Expanded(
                    child: charts.PieChart(
                      _generateObject(bgTask, 3), // TODO: Manage colour (red, green)
                      animate: true,
                      animationDuration: Duration(seconds: 0), //TODO: test different animationDuration
                      defaultRenderer: new charts.ArcRendererConfig(
                          arcWidth: 50,
                          arcRendererDecorators: [
                            new charts.ArcLabelDecorator(
                                labelPosition: charts.ArcLabelPosition.inside
                            )
                          ],
                      ),
                    ),
                  ),
                ],
            ),
          ),
        ),
      ),
    );
  }
}

class DistanceDataPie{
  String distance;
  double distancevalue;
  Color colorvalue;

  DistanceDataPie(this.distance, this.distancevalue, this.colorvalue);
}