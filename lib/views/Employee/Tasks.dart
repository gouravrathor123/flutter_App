import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/views/Employee/ETaskAbout.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/Models/EmployeeModel/ListedEmployeeTask.dart';

import '../../main.dart';

// ignore: must_be_immutable
class Tasks extends StatefulWidget {
  String token;

  Tasks({this.token});

  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  ListedEmployeeTask inprogress = ListedEmployeeTask();
  ListedEmployeeTask completed = ListedEmployeeTask();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    getData1();
  }

  getData() async {
    String lo = Global.local;
    var res = await http.get(
      "http://$lo:3005/employee/getIncompleted/Task",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': widget.token
      },
    );
    var r = json.decode(res.body);
    setState(() {
      inprogress = ListedEmployeeTask.fromJson(r);
    });
    print(inprogress.result[0].title);
  }

  getData1() async {
    String lo = Global.local;
    var res = await http.get(
      "http://$lo:3005/employee/getCompleted/Task",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': widget.token
      },
    );
    var r = json.decode(res.body);
    setState(() {
      completed = ListedEmployeeTask.fromJson(r);
    });
    print(completed.result[0].title);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Tasks"),
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'Inprocess Tasks',
              ),
              Tab(
                text: 'Completed Tasks',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: inprogress.result.length,
                itemBuilder: (BuildContext context, index) {
                  final item = inprogress.result[index];
                  return ListTile(
                    title: Text(
                      item.title,
                      style: TextStyle(fontSize: 30),
                    ),
                    trailing: Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ETaskAbout(
                            id:item.id
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Container(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: completed.result.length,
                itemBuilder: (BuildContext context, index) {
                  final item = completed.result[index];
                  return ListTile(
                    title: Text(
                      item.title,
                      style: TextStyle(fontSize: 30),
                    ),
                    trailing: Icon(Icons.navigate_next),
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => TaskAbout(
                      //           id: item.id,
                      //         )));
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
