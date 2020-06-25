import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'HomeView.dart';
import 'package:digiroad/data/ServerRequest.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

// Used for controlling whether the user is loggin or creating an account
enum FormType {
  login,
  register
}

class _LoginPageState extends State<LoginPage> {
  SharedPreferences sharedPreferences;

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("token") != null) {
      print('you are already logged in');
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return HomeView();
      }));
    } else if (sharedPreferences.getBool("UseWithoutAccount") == true) {
      print('you want to the app Without Account');
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return HomeView();
      }));
    }
  }

  UseWithoutAccount() async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("UseWithoutAccount", true);
    print("settings saved");
  }
 
  final TextEditingController _usernameFilter = new TextEditingController();
  final TextEditingController _passwordFilter = new TextEditingController();
  String _username = "";
  String _password = "";
  String _hint =" ";
  FormType _form = FormType.login; // our default setting is to login, and we should switch to creating an account when the user chooses to

  _LoginPageState() {
    _usernameFilter.addListener(_usernameListen);
    _passwordFilter.addListener(_passwordListen);
  }

  void _usernameListen() {
    if (_usernameFilter.text.isEmpty) {
      _username = "";
    } else {
      _username = _usernameFilter.text;
    }
  }

  void _passwordListen() {
    if (_passwordFilter.text.isEmpty) {
      _password = "";
    } else {
      _password = _passwordFilter.text;
    }
  }

  // Swap in between our two forms, registering and logging in
  void _formChange () async {
    setState(() {
      if (_form == FormType.register) {
        _form = FormType.login;
      } else {
        _form = FormType.register;
      }
    });
  }
  void initState() {
    super.initState();
    checkLoginStatus();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: _buildBar(context),
      body: new Container(
        padding: EdgeInsets.all(16.0),
        child: new Column(
          children: <Widget>[
            _buildTextFields(),
            _buildButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      title: new Text("Please login"),
      centerTitle: true,
    );
  }

  Widget _buildTextFields() {
    return new Container (
      child: new Column(
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              new FlatButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context){
                          return AlertDialog(
                            title: Text('Skip Login'),
                            content: SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  Text("If you want to send or receive data, you must log in or create an account. If you do not wish to do so, you can still use the app with limited functionality. You can still create an account later or log in via the settings. ")
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              new FlatButton(
                                child: Text("Yes"),
                                color: Colors.green,
                                onPressed: () {
                                  UseWithoutAccount();
                                  Navigator.of(context).pop();
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(builder: (context) {
                                    return HomeView();
                                  }));
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
                  child: Text("skip for now"))
            ],
          ),
          new Container(
            child: Text(
              '$_hint',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
          new Container(
            child: new TextField(
              controller: _usernameFilter,
              decoration: new InputDecoration(
                  labelText: 'Username'
              ),
            ),
          ),
          new Container(
            child: new TextField(
              controller: _passwordFilter,
              decoration: new InputDecoration(
                  labelText: 'Password'
              ),
              obscureText: true,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildButtons() {
    if (_form == FormType.login) {
      return new Container(
        child: new Column(
          children: <Widget>[
            new RaisedButton(
              child: new Text('Login'),
              onPressed: _loginPressed,
            ),
            new FlatButton(
              child: new Text('Dont have an account? Tap here to register.'),
              onPressed: _formChange,
              color: Colors.orange,
            ),
            new FlatButton(
              child: new Text('Forgot Password?'),
              onPressed: _passwordReset,
            )
          ],
        ),
      );
    } else {
      return new Container(
        child: new Column(
          children: <Widget>[
            new RaisedButton(
                onPressed: () {},
                child: new Text('You have to agree with our Terms of use'),
              color: Colors.red,
            ),
            new RaisedButton(
              child: new Text('Create an Account'),
              onPressed: _createAccountPressed,
            ),
            new FlatButton(
              child: new Text('Have an account? Click here to login.'),
              onPressed: _formChange,
              color: Colors.green,
            )
          ],
        ),
      );
    }
  }

// These functions can self contain any user auth logic required, they all have access to _email and _password
//TODO: Account handling, save login permanently

  void _loginPressed () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return LoginRequest(username: _username, password: _password);
      }));
      print('data is send to Server');
      //_hint = "wrong password - please try again";
    }

  void _createAccountPressed () {
    print('The user wants to create an accoutn with $_username and $_password');
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) {
      return SignUpRequest(username: _username, password: _password);
    }));
    print('data is send to Server');
  }

  void _passwordReset () {
    print("The user wants a password reset request sent to $_username");
  }
}