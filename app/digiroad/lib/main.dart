import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

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

class HomeView extends StatefulWidget {
  @override
  HomeViewState createState() => HomeViewState();

}

class HomeViewState extends State<HomeView> {
  bool isConnected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        child: isConnected ? Text("Connected") : Text("Connect to an device"),
      )
    );
  }
  
}