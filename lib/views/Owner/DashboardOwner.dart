import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/Models/OwnerModel/NestedOwnerData.dart';
import 'package:flutter_app/views/Owner/ODirectory.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_app/views/Owner/OTasks.dart';
import 'package:flutter_app/views/Owner/OTeam.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/views/Owner/OTodo.dart';

import '../../main.dart';
import 'ODailyReports.dart';

// ignore: must_be_immutable
class DashboardOwner extends StatefulWidget {
  String token, ownerId;

  DashboardOwner({this.token, this.ownerId});

  String lo = Global.local;

  @override
  _DashboardOwnerState createState() => _DashboardOwnerState();
}

class _DashboardOwnerState extends State<DashboardOwner> {
  NestedOwnerData main = NestedOwnerData();
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    getData1();
  }

  getData1() async {
    String lo = Global.local;
    var res = await http.get(
      "http://$lo:3005/owner/getProfile",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': widget.token.toString()
      },
    );
    var r = jsonDecode(res.body);
    // print(r.toString());
    setState(() {
      main = NestedOwnerData.fromJson(r);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Column(
                children: <Widget>[
                  // Container(
                  //   height: 100,
                  //   width: 100,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(50),
                  //     color: Colors.black12,
                  //   ),
                  // ),
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 50.0,
                          backgroundImage: main.result.avatar == ""
                              ? NetworkImage(
                                  "https://image.flaticon.com/icons/png/512/16/16363.png")
                              : NetworkImage(
                                  "http://${widget.lo}:3005/ownerprofilepics//${main.result.email}.jpg"),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: ((builder) => bottomSheet()),
                              );
                            },
                            child: Icon(Icons.camera_alt,
                                color: Colors.teal, size: 28.0),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "${main.result.first_name} ${main.result.last_name}",
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),
            ListTile(
              title: Text(
                "Profile",
                style: TextStyle(fontSize: 24),
              ),
              trailing: Icon(Icons.launch, color: Colors.black),
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context)=> Profile()));
              },
            ),
            ListTile(
              title: Text(
                "Settings",
                style: TextStyle(fontSize: 24),
              ),
              trailing: Icon(Icons.settings, color: Colors.black),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                "Sign Out",
                style: TextStyle(fontSize: 24),
              ),
              trailing: Icon(
                Icons.power_settings_new,
                color: Colors.black,
              ),
              onTap: () {
                signout();
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("DashBoard"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Todo(
                            ownerid: widget.ownerId,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      color: Colors.black12,
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.list, size: 120),
                          Text(
                            "Todo",
                            style: TextStyle(fontSize: 24),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> Attendence()));
                    },
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          Center(
                              child: Image.network(
                            "https://banner2.cleanpng.com/20180512/qee/kisspng-computer-icons-working-time-workplace-job-5af77470d13f52.9301518315261666408571.jpg",
                            alignment: Alignment.center,
                          )),
                          Text(
                            'Attendance',
                            style: TextStyle(fontSize: 24),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Tasks(
                            ownerId: widget.ownerId,
                            token: widget.token,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      color: Colors.black12,
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.list_alt_outlined, size: 120),
                          Text(
                            "Tasks",
                            style: TextStyle(fontSize: 24),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DailyReports(
                            ownerId: widget.ownerId,
                            token: widget.token,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      color: Colors.black12,
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.receipt_outlined, size: 120),
                          Text(
                            "Daily Reports",
                            style: TextStyle(fontSize: 24),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> Account()));
                    },
                    child: Card(
                      color: Colors.black12,
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.account_box, size: 120),
                          Text(
                            "Accounts",
                            style: TextStyle(fontSize: 24),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> Catalog()));
                    },
                    child: Card(
                      color: Colors.black12,
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.playlist_add_rounded, size: 120),
                          Text(
                            "Catalog",
                            style: TextStyle(fontSize: 24),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Directory(
                            ownerId: widget.ownerId,
                            token: widget.token,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      color: Colors.black12,
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.contacts, size: 120),
                          Text(
                            "Directory",
                            style: TextStyle(fontSize: 24),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OwnerTeam(
                            ownerId: widget.ownerId,
                            token: widget.token,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      color: Colors.black12,
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.group_add_rounded, size: 120),
                          Text(
                            "Team",
                            style: TextStyle(fontSize: 24),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void signout() async {
    // var res =
    await http.post(
      "http://${widget.lo}:3005/owner/logout",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': widget.token.toString()
      },
    );
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => MyHomePage()),
        (Route<dynamic> route) => false);
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(
        children: [
          Text(
            "Choose Profile Photo",
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton.icon(
                icon: Icon(Icons.camera),
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                label: Text("Camera"),
              ),
              SizedBox(
                width: 120,
              ),
              FlatButton.icon(
                icon: Icon(Icons.image),
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                label: Text("Gallery"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    setState(() {
      _imageFile = pickedFile;
    });
    if (_imageFile != null) {
      updateImage();
    }
  }

  updateImage() async {
    var request = http.MultipartRequest(
        'PATCH', Uri.parse("http://${widget.lo}:3005/owner/uploadavatar"));
    request.files.add(
      await http.MultipartFile.fromPath("avatar", _imageFile.path),
    );
    request.headers.addAll({
      "Content-type": "multipart/form-data",
      'Authorization': widget.token.toString()
    });

    var response = request.send();
    print("done dana done");
  }
}
