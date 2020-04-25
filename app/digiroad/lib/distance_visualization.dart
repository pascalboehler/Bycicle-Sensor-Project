import 'package:flutter/material.dart';
import './BackgroundCollectingTask.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class distance_visualization extends StatefulWidget {
  double distance1;
  double distance2;
  double distance3;
  distance_visualization(this.distance1, this.distance2, this.distance3);
  @override
  _distance_visualizationState createState() => _distance_visualizationState();
}

class _distance_visualizationState extends State<distance_visualization> {
  double maxDistance = 300; // Max Distance to get a static relationship in the chart, maybe it has to change
  Color abstandColor; //TODO: change color if to close
  List<charts.Series<DistanceDataPie,String>> _seriesPieData;
  List<charts.Series<DistanceDataPie,String>> _seriesPieData2;
  List<charts.Series<DistanceDataPie,String>> _seriesPieData3;

  _generateData() {
    var pieData=[
      new DistanceDataPie('Distance', widget.distance1, Colors.red),
      new DistanceDataPie('rest',  maxDistance-widget.distance1, Colors.transparent),
    ];
    _seriesPieData.add(
      charts.Series(
        data:pieData,
        domainFn: (DistanceDataPie task, _)=> task.distance,
        measureFn: (DistanceDataPie task, _)=> task.distancevalue,
        colorFn: (DistanceDataPie task, _)=> charts.ColorUtil.fromDartColor(task.colorvalue),
        id: 'Abstands-messungen',
        labelAccessorFn: (DistanceDataPie row, _)=> '${row.distancevalue}',
      ),
    );
    var pieData2=[
      new DistanceDataPie('Distance', widget.distance2, Colors.green),
      new DistanceDataPie('rest', maxDistance-widget.distance2, Colors.transparent),
    ];
    _seriesPieData2.add(
      charts.Series(
        data:pieData2,
        domainFn: (DistanceDataPie task, _)=> task.distance,
        measureFn: (DistanceDataPie task, _)=> task.distancevalue,
        colorFn: (DistanceDataPie task, _)=> charts.ColorUtil.fromDartColor(task.colorvalue),
        id: 'Abstands-messungen',
        labelAccessorFn: (DistanceDataPie row, _)=> '${row.distancevalue}',
      ),
    );
    var pieData3=[
      new DistanceDataPie('Distance', widget.distance3, Colors.green),
      new DistanceDataPie('rest', maxDistance-widget.distance3, Colors.transparent),
    ];
    _seriesPieData3.add(
      charts.Series(
        data:pieData3,
        domainFn: (DistanceDataPie task, _)=> task.distance,
        measureFn: (DistanceDataPie task, _)=> task.distancevalue,
        colorFn: (DistanceDataPie task, _)=> charts.ColorUtil.fromDartColor(task.colorvalue),
        id: 'Abstands-messungen',
        labelAccessorFn: (DistanceDataPie row, _)=> '${row.distancevalue}',
      ),
    );
  }
  @override
  void initState(){
    // TODO implement initState
    super.initState();
    _seriesPieData = List<charts.Series<DistanceDataPie, String>>();
    _seriesPieData2 = List<charts.Series<DistanceDataPie, String>>();
    _seriesPieData3 = List<charts.Series<DistanceDataPie, String>>();
    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
       Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Center(
            child: Column(
                    children: <Widget>[
                      Text('1'),
                      SizedBox(height: 1.0),
                      Expanded(
                        child: charts.PieChart(
                          _seriesPieData,
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
                      Text('2'),
                      SizedBox(height: 1.0),
                      Expanded(
                        child: charts.PieChart(
                          _seriesPieData2,
                          animate: true,
                          animationDuration: Duration(seconds: 1), //TODO: test different animationDuration
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
                      Text('3'),
                      SizedBox(height: 1.0),
                      Expanded(
                        child: charts.PieChart(
                          _seriesPieData3,
                          animate: true,
                          animationDuration: Duration(seconds: 1), //TODO: test different animationDuration
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