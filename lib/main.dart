import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/views/Employee/LoginEmployee.dart';
import 'package:flutter_app/views/Employee/PhoneEmployee.dart';
import 'package:flutter_app/views/Owner/LoginOwner.dart';
import 'package:flutter_app/views/Owner/PhoneOwner.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(accentColor: Colors.white70),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red, Colors.yellow],
            begin: const FractionalOffset(0.0, 1.0),
            end: const FractionalOffset(0.0, 1.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Center(
            child: Column(
              children: <Widget>[
                RaisedButton(
                  padding: const EdgeInsets.all(10),
                  textColor: Colors.white,
                  color: Colors.green,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginOwner()),
                    );
                  },
                  child: Text("login as owner"),
                ),
                SizedBox(
                  height: 10,
                ),
                RaisedButton(
                  padding: const EdgeInsets.all(10),
                  textColor: Colors.white,
                  color: Colors.green,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginEmployee()),
                    );
                  },
                  child: Text("login as employee"),
                ),
                SizedBox(
                  height: 10,
                ),
                RaisedButton(
                  padding: const EdgeInsets.all(10),
                  textColor: Colors.white,
                  color: Colors.green,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PhoneEmployee()),
                    );
                  },
                  child: Text("signup as employee"),
                ),
                SizedBox(
                  height: 10,
                ),
                RaisedButton(
                  padding: const EdgeInsets.all(10),
                  textColor: Colors.white,
                  color: Colors.green,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PhoneOwner()),
                    );
                  },
                  child: Text("SignUp as owner"),
                ),
              ],
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Global {
  static final local = "192.168.43.106";
}