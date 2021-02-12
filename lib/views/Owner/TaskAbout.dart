import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'OTasks.dart';

import '../../main.dart';

// ignore: must_be_immutable
class TaskAbout extends StatefulWidget {
  String id;
  Object data;

  TaskAbout({this.id, this.data});

  @override
  _TaskAboutState createState() => _TaskAboutState();
}

class _TaskAboutState extends State<TaskAbout> {
  String lo = Global.local;
  TextEditingController titleController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController dateController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    String h = jsonDecode(widget.data)['result']['description'].toString();

    var task = jsonDecode(widget.data)['result'];
    var taskId = task['_id'];
    return Scaffold(
      appBar: AppBar(
        title: Text(task['title']),
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
                var response = await http.put(
                  "http://$lo:3005/owner/editTask/$taskId",
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                  body: jsonEncode(
                    <String, String>{
                      "title": task['title'],
                      "description": task['description'],
                      "status": "true",
                      "due_date": task['due_date'],
                    },
                  ),
                );
                // print(response.body);
              }
              if (value == 'D') {
                var response = await http.delete(
                  "http://$lo:3005/owner/deleteTask/$taskId",
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
                                    child: textSection1(task),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: buttonSection1(
                                      task,
                                      () {
                                        setState(() {
                                          update(task);
                                        });
                                        Navigator.pop(context);
                                      },
                                    ),
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
      body: Column(
        children: [
          Text(
            "Description",
            style: TextStyle(fontSize: 15),
          ),
          Card(
            child: Text(
              task['description'],
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
              task['due_date'],
              style: TextStyle(fontSize: 20),
            ),
          )
        ],
      ),
    );
  }

  Container textSection1(dynamic task) {
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

  Container buttonSection1(dynamic task, Function onClick) {
    return Container(
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 15.0),
      child: RaisedButton(
        onPressed: onClick,
        color: Colors.blueGrey,
        child: Text("Edit"),
      ),
    );
  }

  update(dynamic task) async {
    var response = await http.put(
      "http://$lo:3005/owner/editTask/${task['_id']}",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          "title": titleController.text,
          "description": descriptionController.text,
          "status": "true",
          "due_date": dateController.text,
        },
      ),
    );
  }

  go(dynamic task) {
    if (titleController.text == '') {
      return task['title'];
    } else {
      return titleController.text;
    }
  }
}
