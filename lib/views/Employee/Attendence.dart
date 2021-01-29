import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class Attendence extends StatefulWidget {
  @override
  _AttendenceState createState() => _AttendenceState();
}

class _AttendenceState extends State<Attendence> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendence")
      ),
    );
  }
}
