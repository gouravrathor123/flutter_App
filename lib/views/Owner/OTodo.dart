import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Models/OwnerModel/ListedOwnerTodo.dart';
import 'package:flutter_app/main.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class Todo extends StatefulWidget {
  String ownerid;

  Todo({this.ownerid});

  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  bool value = false;
  final _formKey = GlobalKey<FormState>();
  ListedOwnerTodo list = ListedOwnerTodo();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    String lo = Global.local;
    String id = widget.ownerid.toString();
    print(id);
    var response = await http.get(
      "http://$lo:3005/todo/list/$id",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    var r = jsonDecode(response.body);
    // print("the value of r is  $r");
    setState(() {
      // main = ListedData.fromJson(r);
      list = ListedOwnerTodo.fromJson(r);
    });
    // print(list.result[0].description);
    // print(list.result[0].id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Todo List",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Write Description"),
                  content: Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
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
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: textSection(),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: buttonSection(widget.ownerid),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              });
        },
        backgroundColor: Colors.lightBlue,
        label: Text(
          "Add a task",
          style: TextStyle(fontSize: 18),
        ),
        icon: Icon(Icons.add),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: list.result.length,
        itemBuilder: (BuildContext context, index) {
          final item = list.result[index];
          return Column(
            children: [
              ListTile(
                title: Text(
                  item.description,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                trailing: Wrap(
                  spacing: 12,
                  children: <Widget>[
                    //editing button
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Edit Description"),
                                content: Stack(
                                  overflow: Overflow.visible,
                                  children: <Widget>[
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
                                      key: _formKey,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: textSection1(
                                                  item.description)),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: buttonSection1(
                                                widget.ownerid,
                                                item.id,
                                                item.completed),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            });
                      },
                    ),
                    //delete button
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        delete(widget.ownerid, item.id);
                      },
                    ),
                  ],
                ),
                leading: Wrap(
                    children: [
                      buildCheckbox(
                          item.description, widget.ownerid, item.id, item.completed),
                    ],
                    ),
              ),
              Divider(
                thickness: 1,
              )
            ],
          );
        },
      ),
    );
  }

  final TextEditingController todoController = new TextEditingController();
  final TextEditingController editController = new TextEditingController();

  Container textSection() {
    return Container(
      child: TextFormField(
        controller: todoController,
        autofocus: false,
        cursorColor: Colors.black,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: "Description",
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white70)),
          hintStyle: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Container buttonSection(id) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 15.0),
      child: RaisedButton(
        // ignore: unrelated_type_equality_checks
        onPressed: todoController == ""
            ? null
            : () {
                setState(() {
                  add(todoController.text, id);
                  Navigator.of(context).pop();
                });
              },
        elevation: 0.0,
        color: Colors.purple,
        child: Text("Add", style: TextStyle(color: Colors.white70)),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(500.0)),
      ),
    );
  }

  delete(String id, String todoId) async {
    // var jsonResponse;
    String lo = Global.local;
    var response = await http.delete("http://$lo:3005/todo/delete/$todoId",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 200) {
      getData();
      // jsonResponse = json.decode(response.body);
      // print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  add(String tod, String id) async {
    // var jsonResponse;
    String lo = Global.local;
    var response = await http.post(
      "http://$lo:3005/todo",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{"description": tod, "owner": id,}),
    );
    if (response.statusCode == 200) {
      getData();
      // jsonResponse = json.decode(response.body);
    }
  }

  Container buttonSection1(String ownerid, String todoId, bool complete) {
    print(
        "owner id is $ownerid todo id is $todoId value of complete is $complete");
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 15.0),
      child: RaisedButton(
        // ignore: unrelated_type_equality_checks
        onPressed: editController == ""
            ? null
            : () {
                setState(() {
                  // print(id1);
                  update(editController.text, ownerid, todoId, complete);
                  Navigator.of(context).pop();
                });
              },
        elevation: 0.0,
        color: Colors.purple,
        child: Text("Edit", style: TextStyle(color: Colors.white70)),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(500.0)),
      ),
    );
  }

  update(String updatedDes, String ownerId, String todoId, bool complete) async {
    // var jsonResponse;
    String lo = Global.local;
    var response = await http.put(
      "http://$lo:3005/todo/update/$todoId",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "description": updatedDes,
        "completed": complete.toString(),
        "owner": ownerId,
        "owner_type": "E"
      }),
    );
    if (response.statusCode == 200) {
      getData();
      // jsonResponse = json.decode(response.body);
      print('Response body: ${response.body}');
    }
  }

  Container textSection1(String todo) {
    return Container(
      child: TextFormField(
        controller: editController,
        autofocus: false,
        cursorColor: Colors.black,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white70)),
          hintStyle: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Widget buildCheckbox(String tod, String id, String id1, bool val) => Checkbox(
        value: val,
        activeColor: Colors.teal,
        onChanged: (value) {
          setState(() {
            update(tod, id, id1, value);
          });
        },
      );

}
