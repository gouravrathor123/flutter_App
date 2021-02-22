import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/views/Owner/OTeamDetails.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/Models/OwnerModel/ListedOwnerTeam.dart';

import '../../main.dart';

// ignore: must_be_immutable
class OwnerTeam extends StatefulWidget {
  String token, ownerId;

  OwnerTeam({this.ownerId, this.token});

  String lo = Global.local;

  @override
  _OwnerTeamState createState() => _OwnerTeamState();
}

class _OwnerTeamState extends State<OwnerTeam> {
  ListedOwnerTeam main = ListedOwnerTeam();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    var res = await http.get(
      "http://${widget.lo}:3005/owner/listofemployees/",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': widget.token
      },
    );
    var r = json.decode(res.body);
    setState(() {
      main = ListedOwnerTeam.fromJson(r);
    });
    print(main.result[0].first_name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Team"),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: main.result.length,
        itemBuilder: (BuildContext context, index) {
          final item = main.result[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (builder) => TeamDetails(EmpId: item.id,),
                ),
              );
            },
            child: ListTile(
              title: Text('${item.first_name} ${item.last_name}'),
              subtitle: Column(
                children: [
                  Text(item.occupation),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
