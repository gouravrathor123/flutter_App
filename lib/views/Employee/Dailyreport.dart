import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/views/Employee/DashboardEmployee.dart';
class Dailyreport extends StatefulWidget {
  @override
  _DailyreportState createState() => _DailyreportState();
}

class _DailyreportState extends State<Dailyreport> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      appBar: AppBar(
        title: Text("Daily Report"),
      ),
    );
  }
}
