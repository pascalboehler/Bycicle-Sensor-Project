import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:scoped_model/scoped_model.dart';

// TODO: Stop BackgroundTask when pressed on paused button

class DistanceData {
  double distance1; // distance value from sensor 1
  double distance2; // distance value from sensor 2
  double distance3; // distance value from sensor 3
  DateTime timestamp; // when was it received

  DistanceData(
      {this.distance1, this.distance2, this.distance3, this.timestamp});
}

class BackgroundCollectingTask extends Model {
  static BackgroundCollectingTask of(BuildContext context,
          {bool rebuildOnChange = false}) =>
      ScopedModel.of<BackgroundCollectingTask>(context,
          rebuildOnChange: rebuildOnChange);

  final BluetoothConnection _connection;
  List<int> _buffer = List<int>();

  bool inProgress;

  List<DistanceData> dataList = List<DistanceData>();

  BackgroundCollectingTask._fromConnection(this._connection) {
    _connection.input.listen((data) {
      _buffer += data;

      while (true) {
        //print("exec");
        // if there is a sample, and it is full sent
        int index = _buffer.indexOf('t'.codeUnitAt(0));
        print("exec2 " + index.toString() + " " + 't'.codeUnitAt(0).toString());
        if (index >= 0 && _buffer.length - index >= 4) {
          print("exec3 with data " + _buffer.toString());
          final DistanceData dataSample = DistanceData(
            distance1: _buffer[index + 1] / 1,
            distance2: _buffer[index + 2] / 1,
            distance3: _buffer[index + 3] / 1,
            timestamp: DateTime.now(),
          );
          _buffer.removeRange(0, index + 4);
          print(_buffer.toString());
          print(dataSample.distance3.toString());
          dataList.add(dataSample);
          print(dataList.toString());
          notifyListeners(); // @FIXME do not invoke too often (should be changed for prod, for testing system only sends one value per second)
        } else {
          //print("Broke up with data " + _buffer.toString());
          break;
        }
      }
    }).onDone(() {
      inProgress = false;
      notifyListeners(); // notify all when BackgroundTasks finishes / crashes
    });
  }

  static Future<BackgroundCollectingTask> connect(
      BluetoothDevice server) async {
    final BluetoothConnection connection =
        await BluetoothConnection.toAddress(server.address);
    return BackgroundCollectingTask._fromConnection(connection);
  }

  void dispose() {
    _connection.dispose();
  }

  Future<void> start() async {
    inProgress = true;
    _buffer.clear();
    dataList.clear();
    notifyListeners();
    _connection.output.add(ascii.encode('start'));
    await _connection.output.allSent;
  }

  Future<void> cancel() async {
    inProgress = true;
    notifyListeners();
    _connection.output.add(ascii.encode('stop'));
    await _connection.finish();
  }

  Future<void> pause() async {
    inProgress = false;
    notifyListeners();
    _connection.output.add(ascii.encode('stop'));
    await _connection.output.allSent;
  }

  Future<void> resume() async {
    inProgress = true;
    notifyListeners();
    _connection.output.add(ascii.encode('start'));
    await _connection.output.allSent;
  }
}
