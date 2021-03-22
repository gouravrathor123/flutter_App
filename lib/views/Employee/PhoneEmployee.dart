import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/views/Employee/OtpEmployee.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class PhoneEmployee extends StatefulWidget {
  String lo = Global.local;
  @override
  _PhoneEmployeeState createState() => _PhoneEmployeeState();
}

class _PhoneEmployeeState extends State<PhoneEmployee> {
  bool _isLoading = false;
  String value;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      appBar: AppBar(
        title: Text("Phone Checking"),
      ),
      body: Center(
        child: Container(
          color: Colors.teal,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : Center(
                child: Column(
                  children: [
                    SizedBox(height: 160,),
                    textSection(),
                    buttonSection(),
                  ],
                )
              ),
        ),
      ),
    );
  }

  getOTP(String phone) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var jsonResponse;

    var response = await http.post(
      "http://${widget.lo}:3005/employee/check",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'phone': phone}),
    );
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        sharedPreferences.setString("token", jsonResponse['token']);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => OtpEmployee(value: value)),
            (Route<dynamic> route) => false);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 15.0),
      child: RaisedButton(
        // ignore: unrelated_type_equality_checks
        onPressed: phoneController == ""
            ? null
            : () {
                setState(() {
                  _isLoading = true;
                });
                getOTP(phoneController.text);
              },
        elevation: 0.0,
        color: Colors.purple,
        child: Text("Get OTP", style: TextStyle(color: Colors.white70)),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(500.0)),
      ),
    );
  }

  final TextEditingController phoneController = new TextEditingController();

  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 30.0),
          TextFormField(
            controller: phoneController,
            autofocus: false,
            cursorColor: Colors.white,
            onChanged: (text) {
              value = text;
            },
            obscureText: true,
            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              icon: Icon(Icons.phone, color: Colors.white70),
              hintText: "Phone",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}
