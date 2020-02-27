import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import 'HomeView.dart';

void main() => runApp(DigiRoad());

class DigiRoad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "DigiRoad",
      home: HomeView(),
    );
  }
}
