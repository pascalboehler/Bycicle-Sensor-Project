import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

void main() => runApp(DigiRoad());

class DigiRoad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "DigiRoad",
      home: Scaffold(
        appBar: AppBar(
          title: Text("DigiRoad"),
        ),
        body: Center(
          child: Text("Hallo Welt"),
        ),
      )
    );
  }
}