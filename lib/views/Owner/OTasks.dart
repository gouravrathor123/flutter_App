import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/views/Owner/TaskAbout.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class Tasks extends StatefulWidget {
  String ownerId,token;
  Tasks({this.ownerId,this.token});

  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  var dat;
  List task;
  Object data;
  String employeeId;
  // ListedData main = ListedData();

  @override
  void initState() {
    super.initState();
    // getData();
    // ListOfTasks();
    incomplete();
  }

  incomplete()async{
    String lo = Global.local;
    var res = await http.get(
      "http://$lo:3005/owner/getCompletedTask/",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MDFiOWViNTE1YmRlYzNjYjA1M2U5ZjkiLCJpYXQiOjE2MTI0MjkyMDZ9.-YQMJOLPlXnF2grr86lO3n-k-mlgaif3ExDovNWX_Ik"
      },
    );
    var r= json.decode(res.body);
    setState(() {
      // main = ListedData.fromJson(r);
    });
  }

  @override
  Widget build(BuildContext context) {
    // ListOfTasks();
    // task = jsonDecode(widget.list)['result'];
    return DefaultTabController(
      // initialIndex: 0,
      length: 1,
      child: Text("Hello"),
      // child: Scaffold(
      //   appBar: AppBar(
      //     title: Text("Task Management"),
      //     bottom: TabBar(
      //       tabs: [
      //         Tab(
      //           text: 'In Progress',
      //         ),
      //         Tab(
      //           text: 'Completed',
      //         ),
      //       ],
      //     ),
      //   ),
      //   floatingActionButton: FloatingActionButton.extended(
      //     onPressed: () {
      //       showDialog(
      //           context: context,
      //           builder: (BuildContext context) {
      //             return AlertDialog(
      //               title: Text("Write Description"),
      //               content: Stack(
      //                 overflow: Overflow.visible,
      //                 children: <Widget>[
      //                   Positioned(
      //                     right: -40.0,
      //                     top: -75.0,
      //                     child: InkResponse(
      //                       onTap: () {
      //                         Navigator.of(context).pop();
      //                       },
      //                       child: CircleAvatar(
      //                         child: Icon(Icons.close),
      //                         backgroundColor: Colors.red,
      //                       ),
      //                     ),
      //                   ),
      //                   Form(
      //                     // key: _formKey,
      //                     child: Column(
      //                       mainAxisSize: MainAxisSize.min,
      //                       children: <Widget>[
      //                         Padding(
      //                           padding: EdgeInsets.all(8.0),
      //                           child: textSection(),
      //                         ),
      //                         Padding(
      //                           padding: EdgeInsets.all(8.0),
      //                           child: dropdownSection(),
      //                         ),
      //                         Padding(
      //                           padding: const EdgeInsets.all(8.0),
      //                           child: buttonSection(),
      //                         )
      //                       ],
      //                     ),
      //                   )
      //                 ],
      //               ),
      //             );
      //           });
      //     },
      //     backgroundColor: Colors.lightBlue,
      //     label: Text(
      //       "Add a task",
      //       style: TextStyle(fontSize: 18),
      //     ),
      //     icon: Icon(Icons.add),
      //   ),
      //   body: TabBarView(
      //     children: [
      //       // Container(
      //       //   child: ListView.builder(
      //       //     scrollDirection: Axis.vertical,
      //       //     shrinkWrap: true,
      //       //     itemCount: main.result.length,
      //       //     itemBuilder: (BuildContext context, index) {
      //       //       final item = main.result[index];
      //       //       return Column(
      //       //         children: [
      //       //           // ListTile(
      //       //           //   title: Text(
      //       //           //     item.,
      //       //           //     style: TextStyle(fontSize: 14),
      //       //           //   ),
      //       //           //   leading: CircleAvatar(
      //       //           //       // backgroundImage: NetworkImage(imageUrl),
      //       //           //       ),
      //       //           //   trailing: Icon(Icons.keyboard_arrow_right),
      //       //           //   onTap: () {
      //       //           //     // Navigator.push(context, MaterialPageRoute(builder: (context)=> TaskAbout(id: item['_id'],)));
      //       //           //     abouttask(item.id);
      //       //           //   },
      //       //           // ),
      //       //           Divider(
      //       //             thickness: 1,
      //       //           )
      //       //         ],
      //       //       );
      //       //     },
      //       //   ),
      //       // ),
      //       Container(
      //         // child: ListView.builder(
      //         //   scrollDirection: Axis.vertical,
      //         //   shrinkWrap: true,
      //         //   itemCount: listModel.result.length,
      //         //   // ignore: non_constant_identifier_names
      //         //   itemBuilder: (BuildContext context,Index){
      //         //     final item1 = listModel.result[Index];
      //         //     return Column(
      //         //       children: [
      //         //         ListTile(
      //         //           title: Text(
      //         //             item1.title ,
      //         //             style: TextStyle(fontSize: 14),
      //         //           ),
      //         //         ),
      //         //       ],
      //         //     );
      //         //   },
      //         // ),
      //
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  TextEditingController taskController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController dateController = new TextEditingController();

  // Container textSection() {
  //   return Container(
  //     child: Column(
  //       children: [
  //         TextFormField(
  //           controller: taskController,
  //           autofocus: false,
  //           cursorColor: Colors.black,
  //           style: TextStyle(color: Colors.black),
  //           decoration: InputDecoration(
  //             hintText: "Task",
  //             border: UnderlineInputBorder(
  //                 borderSide: BorderSide(color: Colors.white70)),
  //             hintStyle: TextStyle(color: Colors.black),
  //           ),
  //         ),
  //         TextFormField(
  //           controller: descriptionController,
  //           autofocus: false,
  //           cursorColor: Colors.black,
  //           style: TextStyle(color: Colors.black),
  //           decoration: InputDecoration(
  //             hintText: "Description",
  //             border: UnderlineInputBorder(
  //               borderSide: BorderSide(color: Colors.white70),
  //             ),
  //             hintStyle: TextStyle(color: Colors.black),
  //           ),
  //         ),
  //         TextFormField(
  //           controller: dateController,
  //           autofocus: false,
  //           cursorColor: Colors.black,
  //           style: TextStyle(color: Colors.black),
  //           decoration: InputDecoration(
  //             hintText: "Date",
  //             border: UnderlineInputBorder(
  //               borderSide: BorderSide(color: Colors.white70),
  //             ),
  //             hintStyle: TextStyle(color: Colors.black),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget dropdownSection() {
  //   return Container(
  //     child: DropdownButton(
  //       items: dat.entries
  //           .map<DropdownMenuItem<String>>(
  //               (MapEntry<String, dynamic> e) => DropdownMenuItem<String>(
  //                     value: e.key,
  //                     child: Text(e.value),
  //                   ))
  //           .toList(),
  //       onChanged: (String newKey) {
  //         employeeId = newKey;
  //       },
  //     ),
  //   );
  // }

  // Widget buttonSection() {
  //   return Container(
  //     width: MediaQuery.of(context).size.width,
  //     height: 40.0,
  //     padding: EdgeInsets.symmetric(horizontal: 15.0),
  //     margin: EdgeInsets.only(top: 15.0),
  //     child: RaisedButton(
  //       // ignore: unrelated_type_equality_checks
  //       onPressed: taskController == "" || descriptionController == ""
  //           ? null
  //           : () {
  //               setState(() {
  //                 assign();
  //                 Navigator.of(context).pop();
  //               });
  //             },
  //       elevation: 0.0,
  //       color: Colors.purple,
  //       child: Text("Assign", style: TextStyle(color: Colors.white70)),
  //       shape:
  //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(500.0)),
  //     ),
  //   );
  // }

  // void getData() async {
  //   String s = widget.id;
  //   String lo = Global.local;
  //   var response = await http.get(
  //     "http://$lo:3005/owner/getCompletedTask/",
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'Authorization':
  //           "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MDFiOWViNTE1YmRlYzNjYjA1M2U5ZjkiLCJpYXQiOjE2MTI0MjQ4MTR9.Qh1MnpbfdZ3fpxbn93TtI7PSnx2oZIRp4OVcxnypdzQ"
  //     },
  //   );
  //   dat = jsonDecode(response.body)['result'];
  // }

  // void assign() async {
  //   String s = widget.id;
  //   String lo = Global.local;
  //   var response = await http.post(
  //     "http://$lo:3005/owner/addTask/",
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'Authorization':
  //           "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MDFiOWViNTE1YmRlYzNjYjA1M2U5ZjkiLCJpYXQiOjE2MTI0MjkyMDZ9.-YQMJOLPlXnF2grr86lO3n-k-mlgaif3ExDovNWX_Ik",
  //     },
  //     body: jsonEncode(<String, String>{
  //       "title": taskController.text,
  //       "description": descriptionController.text,
  //       "due_date": dateController.text,
  //       "assigned_to": employeeId,
  //     }),
  //   );
  //   ListOfTasks();
  // }

  // ignore: non_constant_identifier_names

  // ListOfTasks() async {
  //   Map<String, dynamic> jsonResponse;
  //   String lo = Global.local;
  //   var response = await http.get(
  //     "http://$lo:3005/owner/getAllTask/",
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'Authorization':
  //           "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MDFiOWViNTE1YmRlYzNjYjA1M2U5ZjkiLCJpYXQiOjE2MTI0MjkyMDZ9.-YQMJOLPlXnF2grr86lO3n-k-mlgaif3ExDovNWX_Ik"
  //     },
  //   );
  //   if (response.statusCode == 200) {
  //     jsonResponse = json.decode(response.body);
  //     widget.list = response.body;
  //     if (jsonResponse != null) {
  //       setState(() {
  //         // _isLoading = false;
  //       });
  //     }
  //   }
  // }

  // abouttask(String id) async {
  //   Map<String, dynamic> jsonResponse;
  //   String lo = Global.local;
  //   var response = await http.get(
  //     "http://$lo:3005/owner/getTaskById/$id",
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //   );
  //   if (response.statusCode == 200) {
  //     jsonResponse = json.decode(response.body);
  //     data = response.body;
  //     print('json Response is $jsonResponse');
  //     if (jsonResponse != null) {
  //       setState(() {
  //         // _isLoading = false;
  //       });
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => TaskAbout(
  //             id: id,
  //             data: data,
  //
  //           ),
  //         ),
  //       );
  //     }
  //   } else {
  //     setState(() {
  //       // _isLoading = false;
  //     });
  //   }
  // }

}
