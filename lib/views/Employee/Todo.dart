import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class Todo extends StatefulWidget {
  Object to;
  Object emp;
  Todo({this.to,this.emp});

  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  bool value = false;
    final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    List l = jsonDecode(widget.to)['result'];
    String id = widget.emp;
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List",style: TextStyle(
          color: Colors.black,
        fontSize: 35,

        ),),
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
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(padding: EdgeInsets.all(8.0),
                            child: textSection(),),
                          Padding(padding: const EdgeInsets.all(8.0),
                            child: buttonSection(id),
                            ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
        );
      },backgroundColor: Colors.lightBlue, label: Text("Add a task",style: TextStyle(fontSize: 18),), icon: Icon(Icons.add),),
        body:
      ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: l.length,
              itemBuilder: ( BuildContext context, index) {
                final item = l[index];
                //listtile
                return ListTile(
                 title: Text(item["description"],style: TextStyle(fontSize: 30),),
                trailing: Wrap(
                  spacing: 12,
                  children: <Widget>[
                    //editing button
                    IconButton(icon: Icon(Icons.edit), onPressed: (){
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
                                    key: _formKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Padding(padding: EdgeInsets.all(8.0),
                                          child: textSection1()),
                                        Padding(padding: const EdgeInsets.all(8.0),
                                          child: buttonSection1(id,item["_id"],item["completed"]),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          }
                      );
                    },),
                    //delete button
                    IconButton(icon: Icon(Icons.delete), onPressed: (){
                     delete(id,item["_id"]);
                  },),
                    ],
                ),
                leading: Wrap(
                  children: [
                    //buttonSection1(id,item["_id"],item["completed"])
                    buildCheckbox(item["description"],id,item["_id"],item["completed"]),
                  ],
                ),
                //   trailing: Icon(Icons.delete,size: 30, ),onTap: (){
                //    delete(id,item["_id"]);
                // },
                );
              },
            ),
    );
  }


  final TextEditingController todoController = new TextEditingController();
  final TextEditingController editController = new TextEditingController();

  Container textSection(){
    return Container(
      child: TextFormField(
        controller: todoController,
        autofocus: false,
        cursorColor: Colors.black,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
              hintText: "Description",
          border: UnderlineInputBorder(
            borderSide: BorderSide(color:Colors.white70)
          ),
          hintStyle: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Container buttonSection(id){
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
            add(todoController.text,id);
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

    todo(String ram)async{
    Map<String,dynamic> jsonResponse;
    String lo = Global.local;
    var response = await http.get(
      "http://$lo:3005/todo/list/$ram",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      widget.to=response.body;
      if (jsonResponse != null) {
        setState(() {
          // _isLoading = false;
        });
      }
    } else {
    }
  }

    delete(String id,String id1)async {
    var jsonResponse = null;
    String lo = Global.local;
    print(lo);
    var response = await http.delete(
      "http://$lo:3005/todo/delete/$id1",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });
    if (response.statusCode == 200) {
      todo(id);
      jsonResponse = json.decode(response.body);
      // print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

    add(String tod, String id) async{
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      var jsonResponse = null;
      String lo = Global.local;
      var response = await http.post(
        "http://$lo:3005/todo",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "description": tod,
          "owner": id,
          "owner_type": "E"
        }),
      );
      if (response.statusCode == 200) {
        todo(id);
        jsonResponse = json.decode(response.body);
      }
    }
  //update
    update(String tod,String id,String id1,bool complete)async{
  var jsonResponse = null;
  String lo = Global.local;
  var response = await http.put(
      "http://$lo:3005/todo/update/$id1",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    body: jsonEncode(<String, String>{
      "description": tod,
      "completed":complete.toString(),
      "owner": id,
      "owner_type": "E"
    }),
  );
  if (response.statusCode == 200) {
    todo(id);
    jsonResponse = json.decode(response.body);
    // print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}


  Container buttonSection1(id,id1,complete){
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
            print(id1);
            update(editController.text,id,id1,complete);
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

  Container textSection1(){
      return Container(
        child: TextFormField(
          controller: editController,
          autofocus: false,
          cursorColor: Colors.black,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            border: UnderlineInputBorder(
                borderSide: BorderSide(color:Colors.white70)
            ),
            hintStyle: TextStyle(color: Colors.black),
          ),
        ),
      );
    }

    Widget buildCheckbox(String tod,String id,String id1,bool val) => Checkbox(
        value: val,
        activeColor: Colors.teal,
        onChanged: (value){
          setState(() {
            update(tod,id,id1,value);
          });
        },
    );

}
