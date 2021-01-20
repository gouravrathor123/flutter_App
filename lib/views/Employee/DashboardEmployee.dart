import 'package:flutter/material.dart';

class DashboardEmployee extends StatefulWidget {
  @override
  _DashboardEmployeeState createState() => _DashboardEmployeeState();
}

class _DashboardEmployeeState extends State<DashboardEmployee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard Employee"),
      ),
    );
  }
}
