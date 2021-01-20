import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/views/Owner/LoginOwner.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class SignUpSubmitOwner extends StatefulWidget {
  String firstName, lastName, email, pass, dob, phonee;
  SignUpSubmitOwner(
      {this.firstName,
      this.lastName,
      this.email,
      this.pass,
      this.dob,
      this.phonee});
  @override
  _SignUpSubmitOwnerState createState() =>
      _SignUpSubmitOwnerState(firstName, lastName, email, pass, dob, phonee);
}

class _SignUpSubmitOwnerState extends State<SignUpSubmitOwner> {
  bool _isLoading = false;
  String firstName, lastName, email, pass, dob, phonee;
  _SignUpSubmitOwnerState(this.firstName, this.lastName, this.email, this.pass,
      this.dob, this.phonee);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      appBar: AppBar(
        title: Text("Company Details"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red, Colors.yellow],
            begin: const FractionalOffset(0.0, 1.0),
            end: const FractionalOffset(0.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.repeated,
          ),
        ),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  textSection(),
                  buttonSection(),
                ],
              ),
      ),
    );
  }

  final TextEditingController CINController = new TextEditingController();
  final TextEditingController indutryController = new TextEditingController();
  final TextEditingController addressController = new TextEditingController();
  final TextEditingController companynameController =
      new TextEditingController();

  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 30.0),
          TextFormField(
            controller: companynameController,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              icon: Icon(Icons.create_outlined, color: Colors.white70),
              hintText: "Company Name",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: indutryController,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              icon: Icon(Icons.home_repair_service, color: Colors.white70),
              hintText: "Industry",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: CINController,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              icon: Icon(Icons.code, color: Colors.white70),
              hintText: "CIN",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: addressController,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              icon: Icon(Icons.home_work_outlined, color: Colors.white70),
              hintText: "Address",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 15.0),
      child: RaisedButton(
        // ignore: unrelated_type_equality_checks
        onPressed: companynameController == "" ||
                // ignore: unrelated_type_equality_checks
                addressController == "" ||
                // ignore: unrelated_type_equality_checks
                CINController == "" ||
                // ignore: unrelated_type_equality_checks
                indutryController == ""
            ? null
            : () {
                setState(() {
                  _isLoading = true;
                });

                signUp(companynameController.text, indutryController.text,
                    CINController.text, addressController.text);
              },
        elevation: 0.0,
        color: Colors.purple,
        child: Text("Sign Up", style: TextStyle(color: Colors.white70)),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(500.0)),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  signUp(
      String companyName, String industry, String CIN, String address) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var jsonResponse = null;

    var response = await http.post(
      "http://192.168.5.59:3005/owner",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "first_name": firstName,
        "last_name": lastName,
        "date_of_birth": dob,
        "email": email,
        "phone": phonee,
        "password": pass,
        "company_name": companyName,
        "industry": industry,
        "CIN": CIN,
        "address": address
      }),
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
            MaterialPageRoute(builder: (BuildContext context) => LoginOwner()),
            (Route<dynamic> route) => false);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }
}
