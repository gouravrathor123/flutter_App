import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/views/Employee/Account.dart';
import 'package:flutter_app/views/Employee/Attendence.dart';
import 'package:flutter_app/views/Employee/Catalog.dart';
import 'package:flutter_app/views/Employee/Dailyreport.dart';
import 'package:flutter_app/views/Employee/Directory.dart';
import 'package:flutter_app/views/Employee/LoginEmployee.dart';
import 'package:flutter_app/views/Employee/Profile.dart';
import 'package:flutter_app/views/Employee/Tasks.dart';
import 'package:flutter_app/views/Employee/Team.dart';
import 'package:flutter_app/views/Employee/Todo.dart';

class DashboardEmployee extends StatefulWidget {
  final Object data;
  DashboardEmployee({this.data});
  @override
  _DashboardEmployeeState createState() => _DashboardEmployeeState();
}

class _DashboardEmployeeState extends State<DashboardEmployee> {
  @override
  Widget build(BuildContext context) {
    final String firstname = jsonDecode(widget.data)['result']['first_name'];
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
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Profile()));
              },
            ),
            ListTile(
              title: Text("Sign Out", style: TextStyle(fontSize: 24),),
              onTap: (){},
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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Todo()));
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Team()));                  },
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
}
