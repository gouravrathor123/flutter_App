import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Models/OwnerModel/NestedTaskData.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';

// ignore: must_be_immutable
class TaskAbout extends StatefulWidget {
  String id;
  TaskAbout({this.id});
  @override
  _TaskAboutState createState() => _TaskAboutState();
}

class _TaskAboutState extends State<TaskAbout> {
  String lo = Global.local;
  TextEditingController titleController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController dateController = new TextEditingController();
  NestedTaskData taskData = NestedTaskData();

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
      taskData = NestedTaskData.fromJson(r);
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
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text("Edit"),
                  value: "E",
                ),
                PopupMenuItem(
                  child: Text("Delete"),
                  value: "D",
                ),
                PopupMenuItem(
                  child: Text("Mark as Completed"),
                  value: "C",
                )
              ];
            },
            onSelected: (value) async {
              if (value == 'C') {
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
              if (value == 'D') {
                await http.delete(
                  "http://$lo:3005/owner/deleteTask/${widget.id}",
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                );
                Navigator.pop(context);
              }
              if (value == 'E') {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Edit"),
                        content: Stack(
                          overflow: Overflow.visible,
                          children: <Widget>[
                            Positioned(
                              right: -40.0,
                              top: -75.0,
                              child: CircleAvatar(
                                child: Icon(
                                  Icons.close,
                                ),
                                backgroundColor: Colors.red,
                              ),
                            ),
                            Form(
                              // key: _formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: textSection1(),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: buttonSection1(),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    });
              }
            },
          )
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
            )
          ],
        ),
      ),
    );
  }

  Container textSection1() {
    return Container(
      child: Column(
        children: [
          TextFormField(
            autofocus: false,
            controller: titleController,
            cursorColor: Colors.black,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.black),
              labelText: 'Title',
              focusColor: Colors.blue,
            ),
          ),
          TextFormField(
            controller: descriptionController,
            // initialValue: task['description'],
            autofocus: false,
            cursorColor: Colors.black,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white70)),
                hintStyle: TextStyle(color: Colors.black),
                labelText: "Description"),
          ),
          TextFormField(
            controller: dateController,
            // initialValue: task['due_date'],
            autofocus: false,
            cursorColor: Colors.black,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white70)),
                hintStyle: TextStyle(color: Colors.black),
                labelText: "Due Date"),
          ),
        ],
      ),
    );
  }

  Container buttonSection1() {
    return Container(
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 15.0),
      child: RaisedButton(
        onPressed: update,
        color: Colors.blueGrey,
        child: Text("Edit"),
      ),
    );
  }

  update() async {
    await http.put(
      "http://$lo:3005/owner/editTask/${widget.id}",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          "title": titleController.text,
          "description": descriptionController.text,
          "status": "false",
          "due_date": dateController.text,
        },
      ),
    );
    Navigator.of(context).pop();
  }

  go(dynamic task) {
    if (titleController.text == '') {
      return task['title'];
    } else {
      return titleController.text;
    }
  }
}
