import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskAbout extends StatefulWidget {
  String id;
  TaskAbout({this.id});
  @override
  _TaskAboutState createState() => _TaskAboutState();
}

class _TaskAboutState extends State<TaskAbout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id),
      ),
    );
  }
}
