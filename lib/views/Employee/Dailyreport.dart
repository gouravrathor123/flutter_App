import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/Models/EmployeeModel/ListedEDailyReport.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';

// ignore: must_be_immutable
class Dailyreport extends StatefulWidget {
  String token;
  Dailyreport({this.token});
  @override
  _DailyreportState createState() => _DailyreportState();
}

class _DailyreportState extends State<Dailyreport> {
  ListedEDailyReport main = ListedEDailyReport();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData()async{
    String lo = Global.local;
    var res = await http.get(
      "http://$lo:3005/listofalldailyreportforuser/",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': widget.token
      },
    );
    var r = json.decode(res.body);
    setState(() {
      main = ListedEDailyReport.fromJson(r);
    });
    print(main.result[0].report);
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      appBar: AppBar(
        title: Text("Daily Report"),
      ),
      floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                showDialog(
                    context: context,
                    builder:(BuildContext context){
                      return AlertDialog(
                        title: Text("Submit Today's Report"),
                        content: Stack(
                          overflow: Overflow.visible,
                          children: [
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
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: textSection(),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
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
              },
              label: Text("submit report"),
          ),
      body: Container(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: main.result.length,
          itemBuilder: (BuildContext context, index) {
            final item = main.result[index];
            return ListTile(
              title: Text(
                item.report,
                style: TextStyle(fontSize: 30),
              ),
              trailing: Icon(Icons.delete),
              onTap: () {
                delete(item.id);
              },
            );
          },
        ),
      ),
    );
  }

  TextEditingController reportController = new TextEditingController();

  Container textSection() {
    return Container(
      child: Column(
        children: [
          TextFormField(
            controller: reportController,
            autofocus: false,
            cursorColor: Colors.black,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              hintText: "Report",
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white70),
              ),
              hintStyle: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  void assign() async {
    String lo = Global.local;
    var res=await http.post(
      "http://$lo:3005/dailyreport/",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': widget.token,
      },
      body: jsonEncode(<String, String>{
        "report":reportController.text
      }),
    );
    getData();
  }

  Widget buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 15.0),
      child: RaisedButton(
        // ignore: unrelated_type_equality_checks
        onPressed: reportController == ""
            ? null
            : () {
          setState(() {
            assign();
            Navigator.of(context).pop();
          });
        },
        elevation: 0.0,
        color: Colors.purple,
        child: Text("Submit", style: TextStyle(color: Colors.white70)),
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(500.0)),
      ),
    );
  }

  void delete(String id) async{
    String lo = Global.local;
    var res=await http.delete(
      "http://$lo:3005/deletedailyreport/$id",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': widget.token,
      },
    );
    getData();
  }
}
