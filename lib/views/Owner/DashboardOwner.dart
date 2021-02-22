import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/Models/OwnerModel/NestedOwnerData.dart';
import 'package:flutter_app/views/Owner/OTasks.dart';
import 'package:flutter_app/views/Owner/OTeam.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/views/Owner/OTodo.dart';

import '../../main.dart';
import 'ODailyReports.dart';

// ignore: must_be_immutable
class DashboardOwner extends StatefulWidget {
  String token, ownerId;

  DashboardOwner({this.token, this.ownerId});

  String lo = Global.local;

  @override
  _DashboardOwnerState createState() => _DashboardOwnerState();
}

class _DashboardOwnerState extends State<DashboardOwner> {
  NestedOwnerData main = NestedOwnerData();

  @override
  void initState() {
    super.initState();
    getData1();
  }

  getData1() async {
    String lo = Global.local;
    var res = await http.get(
      "http://$lo:3005/owner/getProfile",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': widget.token.toString()
      },
    );
    var r = jsonDecode(res.body);
    // print(r.toString());
    setState(() {
      main = NestedOwnerData.fromJson(r);
    });
  }

  @override
  Widget build(BuildContext context) {
    // getData1();
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.black12,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "${main.result.first_name} ${main.result.last_name}",
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),
            ListTile(
              title: Text(
                "Profile",
                style: TextStyle(fontSize: 24),
              ),
              trailing: Icon(Icons.launch, color: Colors.black),
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context)=> Profile()));
              },
            ),
            ListTile(
              title: Text(
                "Settings",
                style: TextStyle(fontSize: 24),
              ),
              trailing: Icon(Icons.settings, color: Colors.black),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                "Sign Out",
                style: TextStyle(fontSize: 24),
              ),
              trailing: Icon(
                Icons.power_settings_new,
                color: Colors.black,
              ),
              onTap: () {
                signout();
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("DashBoard"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Todo(
                            ownerid: widget.ownerId,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      color: Colors.black12,
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.list, size: 120),
                          Text(
                            "Todo",
                            style: TextStyle(fontSize: 24),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> Attendence()));
                    },
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          Center(
                              child: Image.network(
                            "https://banner2.cleanpng.com/20180512/qee/kisspng-computer-icons-working-time-workplace-job-5af77470d13f52.9301518315261666408571.jpg",
                            alignment: Alignment.center,
                          )),
                          Text(
                            'Attendance',
                            style: TextStyle(fontSize: 24),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Tasks(
                            ownerId: widget.ownerId,
                            token: widget.token,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      color: Colors.black12,
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.list_alt_outlined, size: 120),
                          Text(
                            "Tasks",
                            style: TextStyle(fontSize: 24),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DailyReports(
                            ownerId: widget.ownerId,
                            token: widget.token,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      color: Colors.black12,
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.receipt_outlined, size: 120),
                          Text(
                            "Daily Reports",
                            style: TextStyle(fontSize: 24),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> Account()));
                    },
                    child: Card(
                      color: Colors.black12,
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.account_box, size: 120),
                          Text(
                            "Accounts",
                            style: TextStyle(fontSize: 24),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> Catalog()));
                    },
                    child: Card(
                      color: Colors.black12,
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.playlist_add_rounded, size: 120),
                          Text(
                            "Catalog",
                            style: TextStyle(fontSize: 24),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> Directory()));
                    },
                    child: Card(
                      color: Colors.black12,
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.contacts, size: 120),
                          Text(
                            "Directory",
                            style: TextStyle(fontSize: 24),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OwnerTeam(
                            ownerId: widget.ownerId,
                            token: widget.token,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      color: Colors.black12,
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.group_add_rounded, size: 120),
                          Text(
                            "Team",
                            style: TextStyle(fontSize: 24),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void signout() async {
    var res = await http.post(
      "http://${widget.lo}:3005/owner/logout",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': widget.token.toString()
      },
    );
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        MyHomePage()), (Route<dynamic> route) => false);
  }
}
