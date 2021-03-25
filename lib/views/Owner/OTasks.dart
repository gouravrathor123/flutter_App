import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Models/OwnerModel/ListedOwnerTask.dart';
import 'package:flutter_app/main.dart';
import 'package:http/http.dart' as http;

import 'TaskAbout.dart';

// ignore: must_be_immutable
class Tasks extends StatefulWidget {
  String ownerId, token;
  Tasks({this.ownerId, this.token});

  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  var dat;
  String employeeId;
  ListedOwnerTask incompleteTasks = ListedOwnerTask();
  ListedOwnerTask completeTasks = ListedOwnerTask();

  @override
  void initState() {
    super.initState();
    complete();
    incomplete();
    getData();
  }

  complete() async {
    String lo = Global.local;
    var res = await http.get(
      "http://$lo:3005/owner/getCompletedTask/",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': widget.token
      },
    );
    var r = json.decode(res.body);
    setState(() {
      completeTasks = ListedOwnerTask.fromJson(r);
    });
    print(completeTasks.result[0].status);
  }

  incomplete() async {
    String lo = Global.local;
    var res = await http.get(
      "http://$lo:3005/owner/getIncompletedTask/",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': widget.token
      },
    );
    var r = json.decode(res.body);
    setState(() {
      incompleteTasks = ListedOwnerTask.fromJson(r);
    });
    print(incompleteTasks.result[0].status);
  }

  getData() async {
    String lo = Global.local;
    var response = await http.get(
      "http://$lo:3005/owner/getAllEmployee/${widget.ownerId}",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': widget.token.toString()
      },
    );
    dat = jsonDecode(response.body)['result'];
    // print("getData is called");
  }

  @override
  Widget build(BuildContext context) {
    getData();
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
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Add the task"),
                      content: Stack(
                        overflow: Overflow.visible,
                        children: [
                          Positioned(
                            right: -40.0,
                            top: -75.0,
                            child: InkResponse(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: CircleAvatar(
                                child: Icon(Icons.close),
                                backgroundColor: Colors.red,
                              ),
                            ),
                          ),
                          Form(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: textSection(),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: dropdownSection(),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: buttonSection(),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  });
            },
            backgroundColor: Colors.cyan,
            icon: Icon(Icons.add),
            label: Text("Add task")),
        body: TabBarView(
          children: [
            Container(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: incompleteTasks.result.length,
                itemBuilder: (BuildContext context, index) {
                  final item = incompleteTasks.result[index];
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
                          builder: (context) => TaskAbout(
                            id: item.id,
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
                itemCount: completeTasks.result.length,
                itemBuilder: (BuildContext context, index) {
                  final item = completeTasks.result[index];
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
                              builder: (context) => TaskAbout(
                                    id: item.id,
                                  )));
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

  TextEditingController taskController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController dateController = new TextEditingController();

  Container textSection() {
    return Container(
      child: Column(
        children: [
          TextFormField(
            controller: taskController,
            autofocus: false,
            cursorColor: Colors.black,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              hintText: "Task",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.black),
            ),
          ),
          TextFormField(
            controller: descriptionController,
            autofocus: false,
            cursorColor: Colors.black,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              hintText: "Description",
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white70),
              ),
              hintStyle: TextStyle(color: Colors.black),
            ),
          ),
          TextFormField(
            controller: dateController,
            autofocus: false,
            cursorColor: Colors.black,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              hintText: "Date",
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white70),
              ),
              hintStyle: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget dropdownSection() {
    return Container(
      child: DropdownButton(
        items: dat.entries
            .map<DropdownMenuItem<String>>(
                (MapEntry<String, dynamic> e) => DropdownMenuItem<String>(
                      value: e.key,
                      child: Text(e.value),
                    ))
            .toList(),
        onChanged: (String newKey) {
          employeeId = newKey;
        },
      ),
    );
  }

  Widget buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 15.0),
      child: RaisedButton(
        // ignore: unrelated_type_equality_checks
        onPressed: taskController == "" || descriptionController == ""
            ? null
            : () {
                setState(() {
                  assign();
                  Navigator.of(context).pop();
                });
              },
        elevation: 0.0,
        color: Colors.purple,
        child: Text("Assign", style: TextStyle(color: Colors.white70)),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(500.0)),
      ),
    );
  }

  void assign() async {
    String lo = Global.local;
    await http.post(
      "http://$lo:3005/owner/addTask/",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': widget.token,
      },
      body: jsonEncode(<String, String>{
        "title": taskController.text,
        "description": descriptionController.text,
        "due_date": dateController.text,
        "assigned_to": employeeId,
      }),
    );
    incomplete();
  }

  abouttask(String id) async {
    Map<String, dynamic> jsonResponse;
    String lo = Global.local;
    var response = await http.get(
      "http://$lo:3005/owner/getTaskById/$id",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print('json Response is $jsonResponse');
      if (jsonResponse != null) {
        setState(() {
          // _isLoading = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskAbout(
              id: id,
            ),
          ),
        );
      }
    } else {
      setState(() {
        // _isLoading = false;
      });
    }
  }
}
