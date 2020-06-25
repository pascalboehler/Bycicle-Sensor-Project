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
  MapController mapController = MapController();
  Position _currentPosition;
  String Location;
  Position LocationMap;
  double _latitude = 51.5;
  double _longitude = -0.09;
  Color _LocationButtonColor = Colors.grey;
  Color _toggelMapToCenterColor = Colors.grey;
  bool _toggelMapToCenter;
  Position _position;
  StreamSubscription<Position> _positionStreamSubscription;
  //final List<Position> _positions = <Position>[];

  void _toggleListening() {
    if (_positionStreamSubscription == null) {
      const LocationOptions locationOptions =
      LocationOptions(accuracy: LocationAccuracy.high);
      final Stream<Position> positionStream =
      Geolocator().getPositionStream(locationOptions);
      _positionStreamSubscription = positionStream.listen(
              (Position position) => setState(() {
                Location =  position.toString();
                //cut Location String to the needed format,
                _latitude = double.parse(Location.substring(5,14));
                _longitude = double.parse(Location.substring(22,29));
                _currentPosition = position;
                _LocationButtonColor = Colors.blue; //change Color if location fixed
                if (_toggelMapToCenter == true) {
                  mapController.move(LatLng(_latitude, _longitude), 16);
                }
              })
      );
      _positionStreamSubscription.pause();
    }

    setState(() {
      if (_positionStreamSubscription.isPaused) {
        _positionStreamSubscription.resume();
      } else {
        _positionStreamSubscription.pause();
        _LocationButtonColor = Colors.grey;
      }
    });
  }

  @override
  void dispose() {
    if (_positionStreamSubscription != null) {
      _positionStreamSubscription.cancel();
      _positionStreamSubscription = null;
    }

    super.dispose();
  }
  //TODO: follow position
  @override
  void didUpdateWidget(map oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (Location != Location) {
      mapController.move(LatLng(_longitude,_latitude), 10);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GeolocationStatus>(
        future: Geolocator().checkGeolocationPermissionStatus(),
    builder:
    (BuildContext context, AsyncSnapshot<GeolocationStatus> snapshot) {
    if (!snapshot.hasData) {
    return const Center(child: CircularProgressIndicator());
    }

    if (snapshot.data == GeolocationStatus.denied) {
    return const PlaceholderWidget('Access to location denied',
    'Allow access to the location services for this App using the device settings.');
    }


    return Stack(
      children: <Widget>[
          FlutterMap(
          mapController: mapController,
          options: new MapOptions(
            center: new LatLng(51.5, -0.09),
            zoom: 13.0,
            onPositionChanged: (postion, hasGesture) {
              // print("on position changed ${postion.center.toString()}");
              // if active you can not zoom or move the map
              // mapController.move(LatLng(_latitude, _longitude), 10);
            },
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
                      child: Icon(Icons.location_on, color: Colors.blue, size: 50.0),
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
            onPressed: () {},
            backgroundColor: Colors.grey,
          )
        ),
        Positioned(
          bottom: 80,
          right: 10,
          child: FloatingActionButton(
            child: Icon(Icons.filter_center_focus),
            backgroundColor: _toggelMapToCenterColor, //change button color if enabled or not
            onPressed: () {
              if (_toggelMapToCenter == true) {
                _toggelMapToCenter = false;
                _toggelMapToCenterColor = Colors.grey; //change Button color to grey
              }else {
                _toggelMapToCenter = true;
                _toggelMapToCenterColor = Colors.green; //change Button color to green
              }
            },
          ),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: FloatingActionButton(
            child: Icon(Icons.gps_fixed),
            backgroundColor: _LocationButtonColor, //change button color if location fixed
              onPressed: _toggleListening,
          ),
        ),
        Positioned(
          bottom: 10,
          right: 100,
          child: Text(_currentPosition.toString(), style: TextStyle(color: Colors.black),),
        )
      ],
     );
    }
  );
  }
}

class PlaceholderWidget extends StatelessWidget {
  const PlaceholderWidget(this.title, this.message);

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(title,
              style: const TextStyle(fontSize: 32.0, color: Colors.black54),
              textAlign: TextAlign.center),
          Text(message,
              style: const TextStyle(fontSize: 16.0, color: Colors.black54),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}