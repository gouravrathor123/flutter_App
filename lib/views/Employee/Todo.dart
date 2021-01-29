import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
// ignore: must_be_immutable
class Todo extends StatefulWidget {
  Object to;
  Todo({this.to});
  @override
  _TodoState createState() => _TodoState();
}
class _TodoState extends State<Todo> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final l = jsonDecode(widget.to)["result"];
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo")
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
                      top: -40,
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
                            child: buttonSection(),
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
      body: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: l.length,
              itemBuilder: ( BuildContext context, index) {
                final item = l[index];
                return ListTile(
                 title: Text(item["description"],style: TextStyle(fontSize: 30),),
                  trailing: Icon(Icons.delete,size: 30, ),onTap: (){
                   delete();
                },
                );
              },
            ),
    );
  }

  final TextEditingController todoController = new TextEditingController();

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

  Container buttonSection(){
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
            add(todoController.text);
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

  add(String tod) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var jsonResponse = null;

    var response = await http.post(
      "http://192.168.5.62:3005/todo",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "description": tod,
        "owner": "60091e39d119d65ec8d7810c",
        "owner_type": "E"
      }),
    );
    if (response.statusCode == 200) {
      todo();
      jsonResponse = json.decode(response.body);
      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');
      if (jsonResponse != null) {
        setState(() {

        });
        // Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(
        //         builder: (BuildContext context) => Todo(to: "",)),
        //         (Route<dynamic> route) => false);
      }
    } else {
      setState(() {
        // _isLoading = false;
      });
    }
  }
  todo()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map<String,dynamic> jsonResponse;

    var response = await http.get(
      "http://192.168.5.62:3005/todo/list/60091e39d119d65ec8d7810c",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');
      widget.to=response.body;
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
  delete()async {
    var jsonResponse = null;

    var response = await http.delete(
      "http://192.168.5.62:3005/todo/delete/601280c5f522b121282500d1",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });
    if (response.statusCode == 200) {
      todo();
      jsonResponse = json.decode(response.body);
      // print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (jsonResponse != null) {
        setState(() {

        });
      }
    } else {
      setState(() {
        // _isLoading = false;
      });
    }
  }
}
