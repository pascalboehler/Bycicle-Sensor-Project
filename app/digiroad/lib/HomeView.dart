import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import './BackgroundCollectingTask.dart';
import './SelectBondedDevicePage.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  String _address = "...";
  String _name = "...";

  Timer _discoverableTimeoutTimer;
  int _discoverableTimeoutSecondsLeft = 0;

  BackgroundCollectingTask _collectingTask;
  BackgroundCollectingTask _task;

  bool _autoAcceptPairingRequest = false;

  bool _isMeasuring = false;

  @override
  void initState() {
    _task = BackgroundCollectingTask.of(context, rebuildOnChange: true);
    super.initState();

    // get current bluetooth state
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    Future.doWhile(() async {
      if (await FlutterBluetoothSerial.instance.isEnabled) {
        return false;
      }
      await Future.delayed(Duration(milliseconds: 0xDD));
      return true;
    }).then((_) {
      // Update the Address Field
      FlutterBluetoothSerial.instance.address.then((address) {
        setState(() {
          _address = address;
        });
      });
    });

    FlutterBluetoothSerial.instance.name.then((name) {
      setState(() {
        _name = name;
      });
    });

    // Listen for further state changes:
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      _bluetoothState = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          actions: <Widget>[
            IconButton(
              icon: _isMeasuring ? Icon(Icons.pause) : Icon(Icons.play_arrow),
              onPressed: () async {
                print('Hallo Welt!');
                if (!_isMeasuring) {
                  final BluetoothDevice selDevice = await Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return SelectBondedDevicePage(checkAvailability: false);
                  }));

                  if (selDevice != null) {
                    print("Connected to device!");
                    await _startMeasuring(context, selDevice);
                    if (_collectingTask != null) {
                      setState(() {
                        _isMeasuring = true;
                      });
                    }
                  } else {
                    print(
                        'Error while bonding device, you may need to enable bluetooth!');
                  }
                } else {
                  await _stopMeasuring();
                  setState(() {
                    _isMeasuring = false;
                  });
                }
              },
            )
          ],
        ),
        body: Center(
          child: _isMeasuring
              ? measureData(context)
              : Text(
                  "Please press the play button to start a new measurement row"),
        ));
  }

  Future<void> _startMeasuring(
      BuildContext context, BluetoothDevice device) async {
    print("Hallo");
    try {
      _collectingTask = await BackgroundCollectingTask.connect(device);
      await _collectingTask.start();
    } catch (ex) {
      _isMeasuring = false;
      if (_collectingTask != null) {
        _collectingTask.cancel();
      }
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error occured while connecting!'),
            content: Text('${ex.toString()}'),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: new Text('Close'))
            ],
          );
        },
      );
    }
  }

  Future<void> _stopMeasuring() async {
    if (_collectingTask != null) {
      _collectingTask.cancel();
    }
  }

  Widget measureData(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                  'Sensor 1: ${_collectingTask != null &&  _task.dataList.length != 0 ? _task.dataList.last.distance1 : "NULL"}'),
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                  'Sensor 2: ${_collectingTask != null && _task.dataList.length != 0 ? _task.dataList.last.distance2 : "NULL"}'),
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                  'Sensor 3: ${_collectingTask != null && _task.dataList.length != 0 ? _task.dataList.last.distance3 : "NULL"}'),
            ],
          )
        ],
      ),
    );
  }
}
