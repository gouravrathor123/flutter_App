import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/Models/OwnerModel/ListedDailyReports.dart';
import 'package:flutter_app/main.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class DailyReports extends StatefulWidget {
  String ownerId, token;
  DailyReports({this.ownerId, this.token});
  String lo = Global.local;

  @override
  _DailyReportsState createState() => _DailyReportsState();
}

class _DailyReportsState extends State<DailyReports> {
  ListedDailyReports main = ListedDailyReports();
  // ignore: non_constant_identifier_names
  String Empname ="Gourav";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    var res = await http.get(
      "http://${widget.lo}:3005/listofalldailyreportforowner/",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': widget.token
      },
    );
    var r = json.decode(res.body);
    setState(() {
      main = ListedDailyReports.fromJson(r);
    });
    // print(main.result[0].report);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daily Reports"),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: main.result.length,
        itemBuilder: (BuildContext context, index) {
          final item = main.result[index];
          getNamebyId(item.user_id);
          return ListTile(
            title: Text(item.report),
            subtitle: Column(
              children: [
                Text(item.createdAt.toString()),
                Text(Empname),
              ],
            ),
          );
        },
      ),
    );
  }

  getNamebyId(String id)async{
    var res = await http.get(
      "http://${widget.lo}:3005/employee/$id",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    var r = jsonDecode(res.body);
    setState(() {
      Empname=r['result']['first_name'].toString();
    });
  }
}
