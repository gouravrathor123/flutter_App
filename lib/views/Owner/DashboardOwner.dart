import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/Models/OwnerModel/NestedOwnerData.dart';
import 'package:flutter_app/views/Owner/OTasks.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/views/Owner/OTodo.dart';

import '../../main.dart';

// ignore: must_be_immutable
class DashboardOwner extends StatefulWidget {
  String token, ownerId;

  DashboardOwner({this.token, this.ownerId});

  @override
  _DashboardOwnerState createState() => _DashboardOwnerState();
}

class _DashboardOwnerState extends State<DashboardOwner> {
  // NestedData main = NestedData();
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
    print("the id of the owner is ${widget.ownerId}");
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
              onTap: null,
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
                                  )));
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
                            token:main.result.token,
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
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> Dailyreport()));
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
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> Team()));
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

// todo()async{
//   // Map<String,dynamic> jsonResponse;
//   // String id = main.result.id;
//   // String lo = Global.local;
//   // var response = await http.get(
//   //   "http://$lo:3005/todo/list/$id",
//   //   headers: <String, String>{
//   //     'Content-Type': 'application/json; charset=UTF-8',
//   //   },
//   // );
//   // if (response.statusCode == 200) {
//   //   jsonResponse = json.decode(response.body);
//   //   print('Response to: ${response.body}');
//   //   print(id);
//   //   to=response.body;
//   //   if (jsonResponse != null) {
//   //     setState(() {
//   //       // _isLoading = false;
//   //     });
//       Navigator.push(context, MaterialPageRoute(builder: (context)=> Todo(ownerid: main.result.id,)));
//       print("the owner id is ${main.result.id}");
//     // }
//   // } else {
//   //   setState(() {
//   //     // _isLoading = false;
//   //   });
//   // }
// }

// task()async{
//   Map<String,dynamic> jsonResponse;
//   String id = main.result.id;
//   String lo = Global.local;
//   var response = await http.get(
//     "http://$lo:3005/owner/getAllTask/",
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//       'Authorization': "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MDFiOWViNTE1YmRlYzNjYjA1M2U5ZjkiLCJpYXQiOjE2MTI0MjkyMDZ9.-YQMJOLPlXnF2grr86lO3n-k-mlgaif3ExDovNWX_Ik"
//     },
//   );
//   list=response.body;
//   print("the value of list is $list");
//   Navigator.push(context, MaterialPageRoute(builder: (context)=> Tasks(id:id,list:list)));
// }
}
// 9977633229
// ms. preeti kothari
