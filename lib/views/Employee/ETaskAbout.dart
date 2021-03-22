import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Models/EmployeeModel/NestedETaskData.dart';
import 'package:flutter_app/main.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class ETaskAbout extends StatefulWidget {
  String id;
  ETaskAbout({this.id});
  @override
  _ETaskAboutState createState() => _ETaskAboutState();
}

class _ETaskAboutState extends State<ETaskAbout> {
  String lo = Global.local;
  NestedETaskData taskData = NestedETaskData();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData()async{
    var res = await http.get(
      "http://$lo:3005/owner/getTaskById/${widget.id}",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    var r = json.decode(res.body);
    setState(() {
      taskData = NestedETaskData.fromJson(r);
    });
    // print(taskData.result.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(taskData.result.title),
        actions: [
          PopupMenuButton<String>(
              itemBuilder: (BuildContext context){
                return [
                  PopupMenuItem(
                    child: Text("Mark as Completed"),
                    value: "C",
                  )
                ];
              },
            onSelected: (value) async {
                if(value=='C'){
                  await http.put(
                    "http://$lo:3005/owner/editTask/${widget.id}",
                    headers: <String, String>{
                      'Content-Type': 'application/json; charset=UTF-8',
                    },
                    body: jsonEncode(
                      <String, String>{
                        "title": taskData.result.title,
                        "description": taskData.result.description,
                        "status": "true",
                        "due_date": taskData.result.due_date,
                      },
                    ),
                  );
                  // print(res.body);
                  Navigator.of(context).pop();
                }
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Description",
              style: TextStyle(fontSize: 15),
            ),
            Card(
              child: Text(
                taskData.result.description,
                style: TextStyle(fontSize: 20),
              ),
              shadowColor: Colors.black,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Due Date",
              style: TextStyle(fontSize: 15),
            ),
            Card(
              child: Text(
                taskData.result.due_date,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
