import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Models/OwnerModel/ListedDirectoryData.dart';
import 'package:flutter_app/main.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class Directory extends StatefulWidget {
  String ownerId, token;

  Directory({this.ownerId, this.token});

  String lo = Global.local;

  @override
  _DirectoryState createState() => _DirectoryState();
}

class _DirectoryState extends State<Directory> {
  final _formKey = GlobalKey<FormState>();
  ListedDirectoryData main = ListedDirectoryData();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    var res = await http.get(
      "http://${widget.lo}:3005/directorylist/${widget.ownerId}",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': widget.token
      },
    );
    var r = json.decode(res.body);
    setState(() {
      main = ListedDirectoryData.fromJson(r);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: Text("My Directory"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          dialogbox("Add Contact","Add");
        },
        label: Text("Add"),
        backgroundColor: Colors.lightBlue,
        icon: Icon(Icons.add),
      ),
      body: Container(
        // color: Colors.teal,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: main.result.length,
          itemBuilder: (BuildContext context, index) {
            final item = main.result[index];
            return Column(
              children: [
                ListTile(
                  title: Text(
                    item.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    item.phone,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  trailing: Wrap(
                    spacing: 12,
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            dialogbox("Edit Contact","Edit");
                          }),
                      IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          onPressed: () {}),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();

  Container textSection() {
    return Container(
      child: Column(
        children: [
          TextFormField(
            controller: nameController,
            autofocus: false,
            cursorColor: Colors.black,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              hintText: "Name",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.black),
            ),
          ),
          TextFormField(
            controller: phoneController,
            autofocus: false,
            cursorColor: Colors.black,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              hintText: "Phone",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Container buttonSection(String ownerId,String label) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 15.0),
      child: RaisedButton(
        // ignore: unrelated_type_equality_checks
        onPressed: nameController == "" || phoneController == ""
            ? null
            : () {
                setState(() {
                  add(nameController.text, phoneController.text);
                  Navigator.of(context).pop();
                });
              },
        elevation: 0.0,
        color: Colors.purple,
        child: Text(label, style: TextStyle(color: Colors.white70)),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(500.0)),
      ),
    );
  }

  add(String name, String phone) async {
    print("add was called");
    var response = await http.post(
      "http://${widget.lo}:3005/directory",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': widget.token
      },
      body: jsonEncode(<String, String>{"name": name, "phone": phone}),
    );
    print(response.body.toString());
    if (response.statusCode == 200) {
      getData();
      // jsonResponse = json.decode(response.body);
    }
  }

  // ignore: missing_return
  Widget dialogbox(String heading,String buttonlabel){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(heading),
            content: Stack(
              overflow: Overflow.visible,
              children: [
                Positioned(
                  right: -40.0,
                  top: -75.0,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(
                      child: Icon(Icons.clear),
                      backgroundColor: Colors.red,
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: textSection(),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: buttonSection(widget.ownerId,buttonlabel),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
