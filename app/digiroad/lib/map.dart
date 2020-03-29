import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'listen_location.dart';
import 'permission_status.dart';
import 'service_enabled.dart';


class map extends StatefulWidget {
  @override
  _mapState createState() => _mapState();
}

class _mapState extends State<map> {

  final Location location = Location();

  LocationData _location;
  String _error;

  Future<void> _getLocation() async {
    setState(() {
      _error = null;
    });
    try {
      final LocationData _locationResult = await location.getLocation();
      setState(() {
        _location = _locationResult;
        print(_location);
      });
    } on PlatformException catch (err) {
      setState(() {
        _error = err.code;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
          FlutterMap(
          options: new MapOptions(
            center: new LatLng(50.1104, 8.68216),
            zoom: 13.0,
          ),
          layers: [
            new TileLayerOptions(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c']
            ),
            new MarkerLayerOptions(
              markers: [
                new Marker(
                  width: 80.0,
                  height: 80.0,
                  point: new LatLng(51.5, -0.09),
                  builder: (ctx) =>
                  new  Container(
                    padding: const EdgeInsets.all(32),
                    child: Container(
                      child: Icon(Icons.location_on),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: FloatingActionButton(
            child: Icon(Icons.navigation),
            onPressed: () {
              print('pressed');
            },
          )
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: FloatingActionButton(
            child: Icon(Icons.gps_fixed),
            backgroundColor: Colors.grey,// @TODO: change background color if location fixed
            onPressed: () {
              print(_getLocation());
            },
          ),
        ),
      ],
    );
  }
}