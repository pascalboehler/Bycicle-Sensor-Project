import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:digiroad/views/routing.dart';


class map extends StatefulWidget {
  @override
  _mapState createState() => _mapState();
}

class _mapState extends State<map> {
  Position _position;
  String Location;
  double _latitude = 51.5;
  double _longitude = -0.09;
  Color _LocationButtonColor = Colors.grey;

  Future<void> _currentPosition() async {
    var geolocator = Geolocator();
    var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);


    StreamSubscription<Position> _positionStream = geolocator.getPositionStream(locationOptions).listen(
            (Position position) {
          print(position == null ? 'Unknown' : position.latitude.toString() + ', ' + position.longitude.toString());
          setState(() {
            Location =  _position.toString();
            //cut Location String to the needed format,
            _latitude = double.parse(Location.substring(5,14));
            _longitude = double.parse(Location.substring(22,29));
            _position = _position;
            _LocationButtonColor = Colors.blue; //change Color if location fixed
          });
        });
  }

  Future<void> _getPosition() async {
    _position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(_position);

    _currentPosition();

    setState(() {
      /*Location =  _positionStream.toString();
      //cut Location String to the needed format,
      _latitude = double.parse(Location.substring(5,14));
      _longitude = double.parse(Location.substring(22,29));
      _position = _position;
      _LocationButtonColor = Colors.blue;*/
    });

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
                //current Position @TODO: center map to this marker
                new Marker(
                  width: 100,
                  height: 100,
                  point: new LatLng(_latitude, _longitude),
                  builder: (ctx) =>
                  new  Container(
                    padding: const EdgeInsets.all(32),
                    child: Container(
                      child: Icon(Icons.navigation, color: Colors.blue, size: 50.0),
                    ),
                  ),
                )
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
              /*Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) {
                return planRoute();
              }));*/
            },
          )
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: FloatingActionButton(
            child: Icon(Icons.gps_fixed),
            backgroundColor: _LocationButtonColor, //change button color if location fixed
            onPressed: () async {
              _getPosition();
            },
          ),
        ),
        Positioned(
          bottom: 10,
          right: 100,
          child: Text(_position.toString(), style: TextStyle(color: Colors.white),),
        )
      ],
    );
  }
}