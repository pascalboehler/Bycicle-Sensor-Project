import 'package:flutter/material.dart';
import 'about.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';
import 'settings_user-account.dart';
import 'TestServerRequest.dart';

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
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) {
                return about();
              }));
            },
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text('User Account setting',
              style: TextStyle(color: Colors.blue[500]
              ),
            ),
          ),

          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('User Account Settings'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) {
                return userAccountSettings();
              }));
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Test Server Request'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) {
                return TestServerRequests();
              }));
            },
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
            title: Text('Sprache'), //TODO:
            onTap: (){
              showDialog(
                context: context,
              builder: (BuildContext context){
                  return AlertDialog(
                    title: Text('language'),
                    content: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: Radio(),
                            title: Text('Deutsch'),
                          ),
                          ListTile(
                            leading: Radio(),
                            title: Text('Englisch'),
                          ),
                          ListTile(
                            leading: Radio(),
                            title: Text('Französisch'),
                          ),
                          ListTile(
                            leading: Radio(),
                            title: Text('Spanisch'),
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      new FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('cancel'))
                    ],
                  );
               }
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.color_lens),
            title: Text('app Thema'), //TODO:
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context){
                    return AlertDialog(
                      title: Text('app theme'),
                      content: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              leading: Radio(),
                              title: Text('black'),
                            ),
                            ListTile(
                              leading: Radio(),
                              title: Text('white'),
                            ),
                            ListTile(
                              leading: Radio(),
                              title: Text('auto'),
                            ),
                            ListTile(
                              leading: Radio(),
                              title: Text('system'),
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        new FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('cancel'))
                      ],
                    );
                  }
              );
            },
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
