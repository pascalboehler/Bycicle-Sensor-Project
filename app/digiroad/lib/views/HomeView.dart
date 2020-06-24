import 'dart:async';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:digiroad/views/distance_visualization.dart';
import 'BluetoothData.dart';
import 'settings.dart';
import 'map.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';


class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  SharedPreferences sharedPreferences;

  checkLoginStatus() async { //
    sharedPreferences = await SharedPreferences.getInstance();

    if(sharedPreferences.getBool("UseWithoutAccount") == true) {
      print('you want to the app Without Account');
    }
    else if (sharedPreferences.getString("token") == null)  {
      print('you are not logged in');
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return LoginPage();
      }));
      }
  }

  int _selectedIndex = 0;

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    distance_visualization(103.5, 204.3, 200), //example Data, TODO: remove or display something useful
    map(),
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
  void initState() {
    super.initState();
    checkLoginStatus();
  }
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
            title: Text('Map')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bluetooth),
            title: Text('Bluetooth Data'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
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
