import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Models/OwnerModel/NestedEmployeeDetails.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';

// ignore: must_be_immutable
class TeamDetails extends StatefulWidget {
  // ignore: non_constant_identifier_names
  String EmpId = "";

  // ignore: non_constant_identifier_names
  TeamDetails({this.EmpId});

  String lo = Global.local;

  _TeamDetailsState createState() => _TeamDetailsState();
}

class _TeamDetailsState extends State<TeamDetails> {
  NestedEmployeeDetails main = NestedEmployeeDetails();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    var res = await http.get(
      "http://${widget.lo}:3005/employee/${widget.EmpId}/",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    var r = json.decode(res.body);
    setState(() {
      main = NestedEmployeeDetails.fromJson(r);
    });
    // print(main.result.first_name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${main.result.first_name} ${main.result.last_name}'),
      ),
      body: Column(
        children: [
          Card(
            child: Text(
              "Name:- ${main.result.first_name} ${main.result.last_name}",
              style: TextStyle(fontSize: 24),
            ),
          ),
          SizedBox(height: 4,),
          Card(
            child: Text(
              "Occupation:- ${main.result.occupation}",
              style: TextStyle(fontSize: 24),
            ),
          ),
          SizedBox(height: 4,),
          Card(
            child: Text(
              "Date of Birth:- ${main.result.date_of_birth}",
              style: TextStyle(fontSize: 24),
            ),
          ),
          SizedBox(height: 4,),
          Card(
            child: Text(
              "Phone:- ${main.result.phone}",
              style: TextStyle(fontSize: 24),
            ),
          ),
          SizedBox(height: 4,),
          Card(
            child: Text(
              "Email:- ${main.result.email}",
              style: TextStyle(fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }
}
