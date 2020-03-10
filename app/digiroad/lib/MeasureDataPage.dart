import 'package:flutter/material.dart';
import './BackgroundCollectingTask.dart';

class MeasureDataPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BackgroundCollectingTask task =
        BackgroundCollectingTask.of(context, rebuildOnChange: true);

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.pause),
            onPressed: () {
              print("Hallo");
              Navigator.of(context).pop();
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                    'Sensor 1: ${task != null && task.dataList.length != 0 ? task.dataList.last.distance1 : "NULL"}'),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                    'Sensor 2: ${task != null && task.dataList.length != 0 ? task.dataList.last.distance2 : "NULL"}'),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                    'Sensor 3: ${task != null && task.dataList.length != 0 ? task.dataList.last.distance3 : "NULL"}'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
