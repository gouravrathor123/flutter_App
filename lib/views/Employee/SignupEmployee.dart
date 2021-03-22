import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/views/Employee/LoginEmployee.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class SignUpEmployee extends StatefulWidget {
  String phonee;
  String lo = Global.local;

  SignUpEmployee({this.phonee});

  @override
  _SignUpEmployeeState createState() => _SignUpEmployeeState();
}

class _SignUpEmployeeState extends State<SignUpEmployee> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child:ListView(
                children: [
                  textSection(),
                  buttonSection(),
                ],
              ),
      ),
    );
  }

  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController occupationController = new TextEditingController();
  TextEditingController dobController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  TextEditingController companyCodeController = new TextEditingController();

  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 30.0),
          TextFormField(
            controller: firstNameController,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              icon: Icon(Icons.create_outlined, color: Colors.white),
              hintText: "First Name",
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              hintStyle: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: lastNameController,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              icon: Icon(Icons.create, color: Colors.white),
              hintText: "Last Name",
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              hintStyle: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: occupationController,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              icon: Icon(Icons.home_repair_service_rounded,
                  color: Colors.white),
              hintText: "Occupation",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),),
              hintStyle: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: dobController,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              icon: Icon(Icons.date_range, color: Colors.white),
              hintText: "Date of Birth",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),),
              hintStyle: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: emailController,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              icon: Icon(Icons.email, color: Colors.white),
              hintText: "Email",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),),
              hintStyle: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: passController,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              icon: Icon(Icons.lock, color: Colors.white),
              hintText: "Password",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),),
              hintStyle: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: companyCodeController,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              icon: Icon(Icons.code, color: Colors.white),
              hintText: "Company Code",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),),
              hintStyle: TextStyle(color: Colors.white),
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
        onPressed: firstNameController.text == "" ||
                // ignore: unrelated_type_equality_checks
                lastNameController.text == "" ||
                // ignore: unrelated_type_equality_checks
                occupationController.text == "" ||
                // ignore: unrelated_type_equality_checks
                dobController.text == "" ||
                // ignore: unrelated_type_equality_checks
                emailController.text == "" ||
                // ignore: unrelated_type_equality_checks
                passController.text == "" ||
                // ignore: unrelated_type_equality_checks
                companyCodeController.text == ""
            ? null
            : () {signUp();},
        elevation: 0.0,
        color: Colors.purple,
        child: Text("Sign Up", style: TextStyle(color: Colors.white70)),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(500.0)),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  signUp()async{
    print("sign up was called");
    print("${widget.lo}");
    var response = await http.post(
      "http://${widget.lo}:3005/employee/",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "first_name": firstNameController.text,
        "last_name": lastNameController.text,
        "date_of_birth": dobController.text,
        "email": emailController.text,
        "phone": widget.phonee,
        "password": passController.text,
        "company_code": companyCodeController.text,
        "createdBy": "E",
        "occupation": occupationController.text,
      }),
    );
    if (response.statusCode == 200) {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => LoginEmployee()),
            (Route<dynamic> route) => false);
      }
  }
}
