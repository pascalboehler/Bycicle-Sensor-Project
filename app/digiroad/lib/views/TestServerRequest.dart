import 'package:flutter/material.dart';
import'package:digiroad/data/ServerRequest.dart';

class TestServerRequests extends StatefulWidget {
  @override
  _TestServerRequestsState createState() => _TestServerRequestsState();
}

class _TestServerRequestsState extends State<TestServerRequests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test Server Request"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                      return UserDataRequest();
                    }));
                  },
                  child: Text("Get User Data"),
              ),
              new FlatButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                    return TripDataRequest(tripNumber: 4);
                  }));
                },
                child: Text("Get User Data for singel Trip"),
              ),
              new FlatButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                    return TripsRequest();
                  }));
                },
                child: Text("Get all trips user made"),
              ),
              new FlatButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                    return TripRequest();
                  }));
                },
                child: Text("Send new Trip (not working on server side yet)"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
