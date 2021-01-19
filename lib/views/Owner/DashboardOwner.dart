import 'package:flutter/material.dart';

class DashboardOwner extends StatefulWidget {
  @override
  _DashboardOwnerState createState() => _DashboardOwnerState();
}

class _DashboardOwnerState extends State<DashboardOwner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DashBoard"),
      ),
    );
  }
}
