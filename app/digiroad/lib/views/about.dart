import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class about extends StatefulWidget {
  @override
  _aboutState createState() => _aboutState();
}

class _aboutState extends State<about> {

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About this App'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Center(
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/digi_road_app_logo.png'), //@TODO: Insert app logo
                    radius: 80,
                  ),
                ),
                Divider(
                  height: 40,
                  color: Colors.grey[600],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('DigiRoad',
                      style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 1.0,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 30.0),
                Row(
                  children: <Widget>[
                    Icon(Icons.edit),
                    SizedBox(width: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Authors', style: TextStyle(
                            fontSize: 18, color: Colors.grey[600]),),
                        new InkWell(
                            child: new Text('the Bycircle Sensor Project',
                              style: TextStyle(
                                  fontSize: 15, letterSpacing: 1.0),),
                            onTap: () =>
                                _launchInBrowser(
                                  ('https://github.com/pascalboehler/Bycicle-Sensor-Project'),)
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  children: <Widget>[
                    Icon(Icons.info),
                    SizedBox(width: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Version', style: TextStyle(
                            fontSize: 18, color: Colors.grey[600]),),
                        new InkWell(
                            child: new Text('0.0.1', //@TODO: version control
                              style: TextStyle(
                                  fontSize: 15, letterSpacing: 1.0),),
                            onTap: () =>
                                _launchInBrowser(
                                  ('https://github.com/pascalboehler/Bycicle-Sensor-Project'),)
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  children: <Widget>[
                    Icon(Icons.insert_drive_file),
                    SizedBox(width: 5.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('License', style: TextStyle(
                            fontSize: 18, color: Colors.grey[600]),),
                        new InkWell(
                            child: new Text('LGLPv3',
                              style: TextStyle(
                                  fontSize: 15, letterSpacing: 1.0),),
                            onTap: () =>
                                _launchInBrowser(
                                  ('https://www.gnu.org/licenses/gpl-3.0.en.html'),)
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    Icon(Icons.map),
                    SizedBox(width: 5.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Map Data is powered by OpenStreetMap', style: TextStyle(fontSize: 18, color: Colors.grey[600]),),
                        new InkWell(
                          child: new Text('https://www.openstreetmap.org/copyright'),
                          onTap: () => _launchInBrowser('https://www.openstreetmap.org/copyright'),
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new FlatButton(
                      onPressed: () {
                        _launchInBrowser('https://startpage.de');
                      },
                      child: Text('Changes'),
                    ),
                    new FlatButton(
                      onPressed: () {
                        _launchInBrowser('https://startpage.de');
                      },
                      child: Text('Source Code'),
                    ),
                    new FlatButton(
                      onPressed: () {
                        _launchInBrowser('https://startpage.de');
                      },
                      child: Text('Privacy'),
                    ),
                  ],
                ),
                SizedBox(height: 15.0),
                SelectableText('Diese App ist OpenSourceSoftware und entstanden im Zuge des Digitechnikum-projekts. Vielen Dank für die Unterstützung.',  textAlign: TextAlign.justify), //@TODO:
                SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new FlatButton(
                        onPressed: () {
                          _launchInBrowser('https://digitechnikum.de/');
                        },
                        child: Text('Digitechnikum'),
                    ),
                    new FlatButton(
                        onPressed: () {
                          _launchInBrowser('https://github.com/pascalboehler/Bycicle-Sensor-Project');
                        },
                        child: Text('Github Repository')
                    ),
                    new FlatButton(
                        onPressed: () {
                          _launchInBrowser('mailto:test@test.de'); //TODO:
                        },
                        child: Text('E-Mail')
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
