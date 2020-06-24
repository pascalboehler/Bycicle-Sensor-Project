import 'package:digiroad/views/TestServerRequest.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:digiroad/views/HomeView.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';



class LoginRequest extends StatefulWidget {
  final username;
  final password;
  const LoginRequest({this.username, this.password});

  @override
  _LoginRequestState createState() => _LoginRequestState();
}

class _LoginRequestState extends State<LoginRequest> {


  //hash Password with SHA256
  hashPassword (String _password) {
    print(_password);
    var key = utf8.encode(_password);
    var bytes = utf8.encode("foobar");

    var hmacSha256 = new Hmac(sha256, key); // HMAC-SHA256
    var digest = hmacSha256.convert(bytes);

    print("HMAC digest as bytes: ${digest.bytes}");
    print("HMAC digest as hex string: $digest");
    return digest.toString();
  }

  Future<http.Response> login() async {
    var url = 'http://digiroad.digitechnikum.de/auth/login';
    var response = await http.get(url, headers: {'username': widget.username, 'user_password_hash': hashPassword(widget.password.toString())});
    var jsonData = null;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if(response.statusCode ==200){
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      jsonData = json.decode(response.body);
      setState(() {
        sharedPreferences.setString("token", jsonData['token']);
        print("token saved");
      });
      print('you are logged in');
      Navigator.of(context)
         .pushReplacement(MaterialPageRoute(builder: (context) {
       return HomeView();
      }));
    }
    else if(response.statusCode == 400) {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      print('wrong password or username');
      //TODO: show error
    }
    else {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      print("Something went wrong");
    }
  }

  @override
  void initState() {
    super.initState();
    login();
  }
  Widget build(BuildContext context) {
    return loadingScreen();
  }
}

class SignUpRequest extends StatefulWidget {
  final username;
  final password;
  const SignUpRequest({this.username, this.password});
  @override
  _SignUpRequestState createState() => _SignUpRequestState();
}

class _SignUpRequestState extends State<SignUpRequest> {

  //hash Password with SHA256
  hashPassword (String _password) {
    print(_password);
    var key = utf8.encode(_password);
    var bytes = utf8.encode("foobar");

    var hmacSha256 = new Hmac(sha256, key); // HMAC-SHA256
    var digest = hmacSha256.convert(bytes);

    print("HMAC digest as bytes: ${digest.bytes}");
    print("HMAC digest as hex string: $digest");
    return digest.toString();
  }

  Future<http.Response> signup() async{
    var url = 'http://digiroad.digitechnikum.de/auth/signup';
    var response = await http.post(url, body: {'username': widget.username, 'user_password_hash': hashPassword(widget.password.toString())} );

    if(response.statusCode ==200){
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      print('you account has been created');
      //TODO: save token
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return HomeView();
      }));
    }
    else if(response.statusCode == 400) {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      print('error please try again');
      //TODO: show error
    }
    else {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      print("Something went wrong");
    }
  }
  @override
  void initState() {
    super.initState();
    signup();
  }
  Widget build(BuildContext context) {
    return loadingScreen();
  }
}

class UserDataRequest extends StatefulWidget {
  //Get user specific dataset for statistics
  @override
  _UserDataRequestState createState() => _UserDataRequestState();
}

class _UserDataRequestState extends State<UserDataRequest>  {
  Future<http.Response>userData ()async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = 'http://digiroad.digitechnikum.de/data/userData';
    var response = await http.get(url, headers: {'token': sharedPreferences.getString("token")} );

    if(response.statusCode ==200){
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
        return TestServerRequests();
      }));
    }
    else if(response.statusCode == 400) {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      print('error please try again');
      //TODO: show error
    }
    else {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      print("Something went wrong");
    }
  }
  @override
  void initState() {
    super.initState();
    userData();
  }
  @override
  Widget build(BuildContext context) {
    return loadingScreen();
  }
}

class TripDataRequest extends StatefulWidget {
  //Get user specific dataset for statistics for single trip
  final tripNumber;
  const TripDataRequest({this.tripNumber});
  @override
  _TripDataRequestState createState() => _TripDataRequestState();
}

class _TripDataRequestState extends State<TripDataRequest>  {

  Future<http.Response>TripData ()async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = 'http://digiroad.digitechnikum.de/data/userData/tripData';
    var response = await http.get(url, headers: {'token': sharedPreferences.getString("token"), 'tripNumber': '$widget.tripNumber'} );

    if(response.statusCode ==200){
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
        return TestServerRequests();
      }));
    }
    else if(response.statusCode == 400) {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      print('error please try again');
      //TODO: show error
    }
    else {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      print("Something went wrong");
    }
  }
  @override
  void initState() {
    super.initState();
    TripData();
  }
  @override
  Widget build(BuildContext context) {
    return loadingScreen();
  }
}

class TripsRequest extends StatefulWidget {
  //Get user specific dataset for statistics for single trip
  @override
  _TripsRequestState createState() => _TripsRequestState();
}

class _TripsRequestState extends State<TripsRequest>  {

  Future<http.Response>Trips ()async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = 'http://digiroad.digitechnikum.de/data/userData/trips';
    var response = await http.get(url, headers: {'token': sharedPreferences.getString("token")} );

    if(response.statusCode ==200){
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
        return TestServerRequests();
      }));
    }
    else if(response.statusCode == 400) {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      print('error please try again');
      //TODO: show error
    }
    else {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      print("Something went wrong");
    }
  }
  @override
  void initState() {
    super.initState();
    Trips();
  }
  @override
  Widget build(BuildContext context) {
    return loadingScreen();
  }
}

class TripRequest extends StatefulWidget {
  //Send new trip to server
  @override
  _TripRequestState createState() => _TripRequestState();
}

class _TripRequestState extends State<TripRequest>  {

  Future<http.Response>Trip ()async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = 'http://digiroad.digitechnikum.de/data/userData/trips';
    var response = await http.post(url, body: {'token': sharedPreferences.getString("token"), 'Trip': '1'} ); //TODO: send real Data

    if(response.statusCode ==200){
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
        return TestServerRequests();
      }));
    }
    else if(response.statusCode == 400) {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      print('error please try again');
      //TODO: show error
    }
    else {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      print("Something went wrong");
    }
  }
  @override
  void initState() {
    super.initState();
    Trip();
  }
  @override
  Widget build(BuildContext context) {
    return loadingScreen();
  }
}

loadingScreen() {
  return Scaffold(
    body: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Please wait a sec',
            style: TextStyle(
              fontSize: 28,
              color: Colors.grey
            ),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(
                strokeWidth: 10,
                backgroundColor: Colors.black,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
              ),
            ],
          )
        ],
      ),
    ),
  );
}