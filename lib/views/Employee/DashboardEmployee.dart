import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/views/Employee/Account.dart';
import 'package:flutter_app/views/Employee/Attendence.dart';
import 'package:flutter_app/views/Employee/Catalog.dart';
import 'package:flutter_app/views/Employee/Dailyreport.dart';
import 'package:flutter_app/views/Employee/Directory.dart';
import 'package:flutter_app/views/Employee/Profile.dart';
import 'package:flutter_app/views/Employee/Tasks.dart';
import 'package:flutter_app/views/Employee/Team.dart';
import 'package:flutter_app/views/Employee/Todo.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DashboardEmployee extends StatefulWidget {
  final Object data;
  DashboardEmployee({this.data});
  @override
  _DashboardEmployeeState createState() => _DashboardEmployeeState();
}

class _DashboardEmployeeState extends State<DashboardEmployee> {
  Object to;
  @override
  void initState(){
    super.initState();
    getData();
  }
  final storage = FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    String firstname = jsonDecode(widget.data)['result']['first_name']+" "+jsonDecode(widget.data)['result']['last_name'];
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(child: Column(
            children: <Widget>[
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.black12,
                ),
              ),
              SizedBox(height: 10),
              Text(firstname,style: TextStyle(fontSize: 18),)
            ],
            ),
            ),
            ListTile(
              title: Text("Profile", style: TextStyle(fontSize: 24),),
              trailing: Icon(Icons.launch,color: Colors.black),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Profile()));
              },
            ),
            ListTile(
              title: Text("Settings", style: TextStyle(fontSize: 24),),
              trailing: Icon(Icons.settings,color: Colors.black),
              onTap: (){

              },
            ),
            ListTile(
              title: Text("Sign Out", style: TextStyle(fontSize: 24),),
              trailing: Icon(Icons.power_settings_new,color: Colors.black,),
              onTap: null,
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Dashboard Employee"),
        backgroundColor: Colors.teal,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.notifications), onPressed: (){})
        ],
      ),
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: Row(
            children: [
            Expanded(
              child: GestureDetector(
                onTap: (){
                  todo();
                },
                child: Card(
                  color: Colors.black12,
                  child:Column(
                    children: <Widget>[
                      Icon(Icons.list,size: 120),
                      Text("Todo",style: TextStyle(fontSize: 24),)
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Attendence()));
                },
                child:Card(
                  child:Column(
                    children: <Widget>[
                      Center(child: Image.network("https://banner2.cleanpng.com/20180512/qee/kisspng-computer-icons-working-time-workplace-job-5af77470d13f52.9301518315261666408571.jpg",alignment: Alignment.center,)),
                      Text("Attendence",style: TextStyle(fontSize: 24),)
                    ],
                  ),
                ),
              ),
            ),
          ],),
          ),
          Expanded(child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Tasks()));
                  },
                  child:Card(
                    color: Colors.black12,
                    child:Column(
                      children: <Widget>[
                        Icon(Icons.list_alt_outlined,size: 120),
                        Text("Tasks",style: TextStyle(fontSize: 24),)
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Dailyreport()));
                  },
                  child:Card(
                    color: Colors.black12,
                    child:Column(
                      children: <Widget>[
                        Icon(Icons.receipt_outlined,size: 120),
                        Text("Daily Reports",style: TextStyle(fontSize: 24),)
                      ],
                    ),
                  ),
                ),
              ),
            ],),
          ),
          Expanded(child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Account()));
                  },
                  child:Card(
                    color: Colors.black12,
                    child:Column(
                      children: <Widget>[
                        Icon(Icons.account_box,size: 120),
                        Text("Accounts",style: TextStyle(fontSize: 24),)
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Catalog()));                  },
                  child:Card(
                    color: Colors.black12,
                    child:Column(
                      children: <Widget>[
                        Icon(Icons.playlist_add_rounded,size: 120),
                        Text("Catalog",style: TextStyle(fontSize: 24),)
                      ],
                    ),
                  ),
                ),
              ),
            ],),
          ),
          Expanded(child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Directory()));                  },
                  child:Card(
                    color: Colors.black12,
                    child:Column(
                      children: <Widget>[
                        Icon(Icons.contacts,size: 120),
                        Text("Directory",style: TextStyle(fontSize: 24),)
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Team()));},
                  child:Card(
                    color: Colors.black12,
                    child:Column(
                      children: <Widget>[
                        Icon(Icons.group_add_rounded,size: 120),
                        Text("Team",style: TextStyle(fontSize: 24),)
                      ],
                    ),
                  ),
                ),
              ),
            ],),
          ),
        ],),
      );
  }

  void getData() async {
    var id = jsonDecode(widget.data)['result']['_id'];
    print(id);
    var res = await http.get("http://localhost:3005/employee/getprofile");
    var r = json.decode(res.body);
    print(r);
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
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      to=response.body;
      if (jsonResponse != null) {
        setState(() {
          // _isLoading = false;
        });
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Todo(to: to,)));
      }
    } else {
      setState(() {
        // _isLoading = false;
      });
    }
  }
}
