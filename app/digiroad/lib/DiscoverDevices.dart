import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import './BluetoothDeviceListEntry.dart';

class DiscoverDevicesPage extends StatefulWidget {
  final bool start;

  const DiscoverDevicesPage({this.start = true});

  @override
  _DiscoverDevicesPageState createState() => _DiscoverDevicesPageState();
}

class _DiscoverDevicesPageState extends State<DiscoverDevicesPage> {
  StreamSubscription<BluetoothDiscoveryResult> _streamSubscription;
  List<BluetoothDiscoveryResult> results = List<BluetoothDiscoveryResult>();
  bool isDiscovering;

  @override
  void initState() {
    super.initState();

    isDiscovering = widget.start;
    if (isDiscovering) {
      _startDiscovery();
    }
  }

  void _restartDiscovery() {
    setState(() {
      results.clear();
      isDiscovering = true;
    });

    _startDiscovery();
  }

  void _startDiscovery() {
    _streamSubscription =
        FlutterBluetoothSerial.instance.startDiscovery().listen((result) {
      setState(() {
        results.add(result);
      });
    });

    _streamSubscription.onDone(() {
      setState(() {
        isDiscovering = false;
      });
    });
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isDiscovering
            ? Text('Discovering devices')
            : Text('Discovered devices'),
        actions: <Widget>[
          (isDiscovering
              ? FittedBox(
                  child: Container(
                  margin: new EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                ))
              : IconButton(
                  icon: Icon(Icons.replay),
                  onPressed: _restartDiscovery,
                ))
        ],
      ),
      body: ListView.builder(
        itemCount: results.length,
        itemBuilder: (BuildContext context, index) {
          BluetoothDiscoveryResult result = results[index];
          return BluetoothDeviceListEntry(
            device: result.device,
            rssi: result.rssi,
            onTap: () {
              Navigator.of(context).pop(result.device);
            },
            onLongPress: () async {
              try {
                bool bonded = false;
                if (result.device.isBonded) {
                  print('Unbonding from ${result.device.name}');
                  await FlutterBluetoothSerial.instance.removeDeviceBondWithAddress(result.device.address);
                  print('Unbonding from ${result.device.name} has succed');
                } else {
                  print('Bonding with ${result.device.name}');
                  bonded = await FlutterBluetoothSerial.instance.bondDeviceAtAddress(result.device.address);
                  print('Bonding with ${result.device.name} has ${bonded ? "succed" : "failes"}');
                }
                setState(() {
                  results[results.indexOf(result)] = BluetoothDiscoveryResult(
                    device: BluetoothDevice(
                      name: result.device.name ?? '',
                      address: result.device.address,
                      type: result.device.type,
                      bondState: bonded ? BluetoothBondState.bonded : BluetoothBondState.none,
                    ),
                    rssi: result.rssi,
                  );
                });
              } catch (ex) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Error occured while bonding'),
                      content: Text('${ex.toString()}'),
                      actions: <Widget>[
                        new FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: new Text("Close"),
                        )
                      ],
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}
