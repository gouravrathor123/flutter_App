import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/views/Employee/DashboardEmployee.dart';
class Directory extends StatefulWidget {
  @override
  _DirectoryState createState() => _DirectoryState();
}

class _DirectoryState extends State<Directory> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      appBar: AppBar(
        title: Text("Directory"),
      ),
    );
  }
}
