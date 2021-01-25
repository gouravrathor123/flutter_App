import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/views/Employee/DashboardEmployee.dart';
class Todo extends StatefulWidget {
  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo"),
      ),
    );
  }
}
