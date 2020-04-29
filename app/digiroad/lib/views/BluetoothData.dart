import 'dart:async';
import 'package:digiroad/views/MeasureDataPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:scoped_model/scoped_model.dart';

import '../data/BackgroundCollectingTask.dart';
import 'SelectBondedDevicePage.dart';
import 'MeasureDataPage.dart';

class BluetoothData extends StatefulWidget {
  @override
  _BluetoothDataState createState() => _BluetoothDataState();
  bool isConnected = false;
}

class _BluetoothDataState extends State<BluetoothData> {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  String _address = "...";
  String _name = "...";

  Timer _discoverableTimeoutTimer;
  int _discoverableTimeoutSecondsLeft = 0;

  BackgroundCollectingTask _collectingTask;

  bool _autoAcceptPairingRequest = false;

  @override
  void initState() {
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
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: new FloatingActionButton(
                    onPressed: ()  async {
                      print('Hallo Welt!');
                      final BluetoothDevice selDevice = await Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return SelectBondedDevicePage(checkAvailability: false);
                      }));

                      if (selDevice != null) {
                        print("Connected to device!");
                        await _startMeasuring(context, selDevice);
                        if (_collectingTask != null) {
                          print("opening page route");
                          await Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return ScopedModel<BackgroundCollectingTask>(
                              model: _collectingTask,
                              child: MeasureDataPage(),
                            );
                          }));
                        }
                      } else {
                        print(
                            'Error while bonding device, you may need to enable bluetooth!');
                      }
                    },
                    child: Icon(Icons.play_arrow),
                ),
              ),
              Center(
                child: Text(
                    "Please press the play button to start a new measurement row"),
              ),
            ],
          ),
        ));
  }

  Future<void> _startMeasuring(
      BuildContext context, BluetoothDevice device) async {
    try {
      _collectingTask = await BackgroundCollectingTask.connect(device);
      await _collectingTask.start();
    } catch (ex) {
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
}

