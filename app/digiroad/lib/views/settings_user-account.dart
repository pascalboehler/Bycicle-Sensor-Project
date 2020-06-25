import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';

class userAccountSettings extends StatefulWidget {
  @override
  _userAccountSettingsState createState() => _userAccountSettingsState();
}

class _userAccountSettingsState extends State<userAccountSettings> {

  String accountStatus = '';

  SharedPreferences sharedPreferences;

  LogOut() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("token") == null) {
      print('you are not logged In');
    }
    else {
      sharedPreferences.clear();
      Navigator.of(context).pop();
    }
  }
  logIn() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getBool("UseWithoutAccount") == true) {
      sharedPreferences.setBool("UseWithoutAccount", false);
    }
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return LoginPage();
    }));
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();

    if(sharedPreferences.getBool("UseWithoutAccount") == true) {
      print('you want to the app Without Account');
      setState(() {
        accountStatus = 'use without account';
      });
    }
    else if (sharedPreferences.getString("token") == null)  {
      print('you are not logged in');
      setState(() {
        accountStatus = 'Not logged In';
      });
    }
    else {
      print ("You are logged In");
      setState(() {
        accountStatus ="You Are Logged In";
      });
    }
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLoginStatus();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UserAccountSettings"),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Account Status: '+ accountStatus), //TODO:
              onTap: (){},
            ),
            ListTile(
              leading: Icon(Icons.language),
              title: Text('Log out'), //TODO:
              onTap: (){
                showDialog(
                    context: context,
                    builder: (BuildContext context){
                      return AlertDialog(
                        title: Text('Log Out'),
                        content: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Text("Are you sure?")
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          new FlatButton(
                            child: Text("Yes"),
                            color: Colors.green,
                            onPressed: () {
                              LogOut();
                            },
                          ),
                          new FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('No'),
                            color: Colors.red,
                          ),
                        ],
                      );
                    }
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.language),
              title: Text('Log In'), //TODO:
              onTap: (){
                logIn();
              },
            ),
          ],
        ),
      ),
    );

  }
}
