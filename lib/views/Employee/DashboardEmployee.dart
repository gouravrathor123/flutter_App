import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Models/EmployeeModel/NestedEmployeeData.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/views/Employee/Account.dart';
import 'package:flutter_app/views/Employee/Attendence.dart';
import 'package:flutter_app/views/Employee/Catalog.dart';
import 'package:flutter_app/views/Employee/Dailyreport.dart';
import 'package:flutter_app/views/Employee/Profile.dart';
import 'package:flutter_app/views/Employee/Tasks.dart';
import 'package:flutter_app/views/Employee/Team.dart';
import 'package:flutter_app/views/Employee/Todo.dart';
import 'package:flutter_app/views/Owner/OTodo.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class DashboardEmployee extends StatefulWidget {
  String token, empId;
  String lo = Global.local;

  DashboardEmployee({this.empId, this.token});

  @override
  _DashboardEmployeeState createState() => _DashboardEmployeeState();
}

class _DashboardEmployeeState extends State<DashboardEmployee> {
  NestedEmployeeData main = NestedEmployeeData();

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    print("${widget.lo}  ${widget.token}");
    var res = await http.get(
      "http://${widget.lo}:3005/employee/getProfile",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': widget.token
      },
    );
    var r = jsonDecode(res.body);
    print(r.toString());
    setState(() {
      main = NestedEmployeeData.fromJson(r);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Profile()));
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
        title: Text("Dashboard Employee"),
        backgroundColor: Colors.teal,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.notifications), onPressed: () {})
        ],
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
                                  ownerid: widget.empId,
                                )),
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Attendence()));
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
                            "Attendence",
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
                          builder: (context) => Tasks(token: widget.token),
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
                          builder: (context) => Dailyreport(
                            token:widget.token
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Account()));
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Catalog()));
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Team()));
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

  todo() async {
    Map<String, dynamic> jsonResponse;
    String lo = Global.local;
    var response = await http.get(
      "http://$lo:3005/todo/list/${widget.empId}",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          // _isLoading = false;
        });
      }
    } else {
      setState(() {
        // _isLoading = false;
      });
    }
  }

  void signout() async {
    await http.post(
      "http://${widget.lo}:3005/employee/logout",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': widget.token.toString()
      },
    );
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => MyHomePage()),
        (Route<dynamic> route) => false);
  }
}
