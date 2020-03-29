import 'package:flutter/material.dart';

class settings extends StatefulWidget {
  @override
  _settingsState createState() => _settingsState();
}

class _settingsState extends State<settings> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text('über diese App'),
            onTap: () {},
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text('allgemeines',
            style: TextStyle(color: Colors.blue[500]
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text('Sprache'),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.color_lens),
            title: Text('app Thema'),
            onTap: () {},
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text('Bluetooth Einstellungen',
            style: TextStyle(color: Colors.blue[500]
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.bluetooth),
            title: Text('Bluetooth Platzhalter 1'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.bluetooth),
            title: Text('Bluetooth Platzhalter 2'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
