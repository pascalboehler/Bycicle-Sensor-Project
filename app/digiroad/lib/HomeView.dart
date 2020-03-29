import 'dart:async';
import 'package:digiroad/MeasureDataPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:scoped_model/scoped_model.dart';

import './BackgroundCollectingTask.dart';
import './SelectBondedDevicePage.dart';
import './MeasureDataPage.dart';
import './BluetoothData.dart';
import './settings.dart';


class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Karte',
      style: optionStyle,
    ),
    BluetoothData(),
    settings(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // TODO: update AppBar title
    });
  }
  static String _title ='Home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            title: Text('Karte')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bluetooth),
            title: Text('Bluetooth Data'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Einstellungen'),
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
