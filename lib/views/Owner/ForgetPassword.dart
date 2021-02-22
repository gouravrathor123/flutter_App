import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/views/Owner/PassCode.dart';
import 'package:http/http.dart' as http;

class ForgetPassword extends StatefulWidget {
  String lo = Global.local;
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forget Password"),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.lightBlue),
        child: ListView(
          children: [
            SizedBox(
              height: 40,
            ),
            Center(
              child: Text(
                "Forget Password",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
            textSection(),
            buttonSection(),
          ],
        ),
      ),
    );
  }

  TextEditingController emailController = new TextEditingController();

  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children:[
          TextFormField(
            controller: emailController,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              hintText: "Enter email",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
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
        onPressed: emailController.text == ""
            ? null
            : () async{
          var response = await http.post(
            "http://${widget.lo}:3005/owner/forget",
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',},
              body: jsonEncode(<String, String>{
                "email" : emailController.text
                    })
          );
          print(response.body.toString());
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PassCode(email:emailController.text),
            ),
          );
        },
        elevation: 0.0,
        color: Colors.purple,
        child: Text("Send PassCode", style: TextStyle(color: Colors.white70)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }
}
