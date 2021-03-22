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
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text("Home Page"),
    //   ),
    //   body: Container(
    //     height: MediaQuery.of(context).size.height,
    //     width: MediaQuery.of(context).size.width,
    //     decoration: BoxDecoration(
    //       gradient: LinearGradient(
    //         colors: [Colors.red, Colors.yellow],
    //         begin: const FractionalOffset(0.0, 1.0),
    //         end: const FractionalOffset(0.0, 1.0),
    //       ),
    //     ),
    //     child: Padding(
    //       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    //       child: Center(
    //         child: Column(
    //           children: <Widget>[
    //             RaisedButton(
    //               padding: const EdgeInsets.all(10),
    //               textColor: Colors.white,
    //               color: Colors.green,
    //               onPressed: () {
    //                 Navigator.push(
    //                   context,
    //                   MaterialPageRoute(builder: (context) => LoginOwner()),
    //                 );
    //               },
    //               child: Text("login as owner"),
    //             ),
    //             SizedBox(
    //               height: 20,
    //             ),
    //             RaisedButton(
    //               padding: const EdgeInsets.all(10),
    //               textColor: Colors.white,
    //               color: Colors.green,
    //               onPressed: () {
    //                 Navigator.push(
    //                   context,
    //                   MaterialPageRoute(builder: (context) => LoginEmployee()),
    //                 );
    //               },
    //               child: Text("login as employee"),
    //             ),
    //             SizedBox(
    //               height: 20,
    //             ),
    //             RaisedButton(
    //               padding: const EdgeInsets.all(10),
    //               textColor: Colors.white,
    //               color: Colors.green,
    //               onPressed: () {
    //                 Navigator.push(
    //                   context,
    //                   MaterialPageRoute(builder: (context) => PhoneEmployee()),
    //                 );
    //               },
    //               child: Text("signup as employee"),
    //             ),
    //             SizedBox(
    //               height: 20,
    //             ),
    //             RaisedButton(
    //               padding: const EdgeInsets.all(10),
    //               textColor: Colors.white,
    //               color: Colors.green,
    //               onPressed: () {
    //                 Navigator.push(
    //                   context,
    //                   MaterialPageRoute(builder: (context) => PhoneOwner()),
    //                 );
    //               },
    //               child: Text("SignUp as owner"),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ), // This trailing comma makes auto-formatting nicer for build methods.
    // )
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Center(child: Text("Welcome")),
            bottom: TabBar(
              tabs: [
                Tab(
                  text: "Owner",
                ),
                Tab(
                  text: "Employee",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Container(
                color: Colors.grey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Sign In",
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Phone',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow:
                              [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 6,
                                  offset: Offset(0,2)
                                ),
                              ]
                          ),
                          height: 60,
                        ),
                      ],
                    ),
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
                      child: Text("Login"),
                    ),
                    SizedBox(
                      height: 20,
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
                      child: Text("Sign Up"),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.grey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RaisedButton(
                      padding: const EdgeInsets.all(10),
                      textColor: Colors.white,
                      color: Colors.green,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginEmployee()),
                        );
                      },
                      child: Text("Login"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      padding: const EdgeInsets.all(10),
                      textColor: Colors.white,
                      color: Colors.green,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PhoneEmployee()),
                        );
                      },
                      child: Text("Sign Up"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Global {
  static final local = "192.168.0.108";
}
