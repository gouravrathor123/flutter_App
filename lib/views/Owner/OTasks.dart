import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/views/Owner/TaskAbout.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class Tasks extends StatefulWidget {
  final String id;
  Object list;
  Tasks({this.id,this.list});
  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  var dat;
  List task;
  String employeeId;
  @override
  void initState() {
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    task = jsonDecode(widget.list)['result'];
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Task Management"),
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'In Progress',
              ),
              Tab(
                text: 'Completed',
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(onPressed: (){
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
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                          child: CircleAvatar(
                            child: Icon(Icons.close),
                            backgroundColor: Colors.red,
                          ),
                        ),
                      ),
                      Form(
                        // key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(padding: EdgeInsets.all(8.0),
                              child: textSection(),),
                            Padding(padding: EdgeInsets.all(8.0),
                              child: dropdownSection(),),
                            Padding(padding: const EdgeInsets.all(8.0),
                              child: buttonSection(),)
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
          );
        },backgroundColor: Colors.lightBlue, label: Text("Add a task",style: TextStyle(fontSize: 18),), icon: Icon(Icons.add),),
        body: TabBarView(
          children: [
            Container(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: task.length,
                itemBuilder: ( BuildContext context, index) {
                  final item = task[index];
                  return ListTile(
                    title: Text(item['title'],style: TextStyle(fontSize: 30),),
                    leading: CircleAvatar(
                      // backgroundImage: NetworkImage(imageUrl),
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> TaskAbout(id: item['_id'],)));
                    },
                  );
                },
              ),
            ),
            Container(
              color: Colors.deepOrangeAccent,
              child: Center(child: Text("all completed tasks")),
            ),
          ],
        ),
      ),
    );
  }

  TextEditingController taskController = new TextEditingController();

  Container textSection(){
    return Container(
      child: TextFormField(
        controller: taskController,
        autofocus: false,
        cursorColor: Colors.black,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: "Task",
          border: UnderlineInputBorder(
              borderSide: BorderSide(color:Colors.white70)
          ),
          hintStyle: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Widget dropdownSection(){
    return Container(
      child: DropdownButton(
        items: dat.entries.map<DropdownMenuItem<String>>(
                (MapEntry<String, dynamic> e) => DropdownMenuItem<String>(
              value: e.key,
              child: Text(e.value),
            ))
            .toList(),
        onChanged: (String newKey) {
          employeeId=newKey;
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
        onPressed: taskController == ""
            ? null
            : () {
          setState(() {
            assign(taskController.text);
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

  void getData () async{
    String s = widget.id;
    String lo = Global.local;
    var response = await http.get(
      "http://$lo:3005/owner/getAllEmployee/$s",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MDFiOWViNTE1YmRlYzNjYjA1M2U5ZjkiLCJpYXQiOjE2MTI0MjQ4MTR9.Qh1MnpbfdZ3fpxbn93TtI7PSnx2oZIRp4OVcxnypdzQ"
      },);
    dat=jsonDecode(response.body)['result'];
  }

  void assign(String task)async{
    String s = widget.id;
    String lo = Global.local;
    var response = await http.post(
      "http://$lo:3005/owner/addTask/",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MDFiOWViNTE1YmRlYzNjYjA1M2U5ZjkiLCJpYXQiOjE2MTI0MjkyMDZ9.-YQMJOLPlXnF2grr86lO3n-k-mlgaif3ExDovNWX_Ik",
      },body: jsonEncode(<String, String>{
        "title": task,
        "description":"this is the second task mane by gourav",
        "due_date":"2021/02/06",
        "assigned_to": employeeId,
        }
    ),);
    ListOfTasks();
  }

  // ignore: non_constant_identifier_names
  ListOfTasks()async{
    Map<String,dynamic> jsonResponse;
    String lo = Global.local;
    var response = await http.get(
      "http://$lo:3005/owner/getAllTask/",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MDFiOWViNTE1YmRlYzNjYjA1M2U5ZjkiLCJpYXQiOjE2MTI0MjkyMDZ9.-YQMJOLPlXnF2grr86lO3n-k-mlgaif3ExDovNWX_Ik"
      },
    );
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      widget.list=response.body;
      if (jsonResponse != null) {
        setState(() {
          // _isLoading = false;
        });
      }
    } else {
    }
  }

}
