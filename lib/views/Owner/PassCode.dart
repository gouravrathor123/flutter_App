import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:http/http.dart' as http;

import 'LoginOwner.dart';

// ignore: must_be_immutable
class PassCode extends StatefulWidget {
  String lo = Global.local;
  String email;
  PassCode({this.email});
  @override
  _PassCodeState createState() => _PassCodeState();
}

class _PassCodeState extends State<PassCode> {
  bool statusCode = false;

  @override
  Widget build(BuildContext context) {
    TextEditingController passCodeController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Pass Code"),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue, Colors.teal],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Text(
                'Enter the PassCode from your email',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: passCodeController,
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white70),
                decoration: InputDecoration(
                  hintText: "Enter the PassCode",
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70)),
                  hintStyle: TextStyle(color: Colors.white70),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              RaisedButton(
                onPressed: () {
                  passcodeverify(passCodeController.text);
                },
                child: Text("Submit"),
              ),
              SizedBox(
                height: 30,
              ),
              statusCode
                  ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: passwordController,
                          cursorColor: Colors.white,
                          style: TextStyle(color: Colors.white70),
                          decoration: InputDecoration(
                            hintText: "Enter the new Password",
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white70)),
                            hintStyle: TextStyle(color: Colors.white70),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        RaisedButton(
                          onPressed: () {
                            changePassword(passwordController.text);
                          },
                          child: Text("change password"),
                        )
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  passcodeverify(String passcode) async {
    var res = await http.post(
      "http://${widget.lo}:3005/owner/reset",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'passcode': passcode,
        'email': widget.email
      }),
    );
    if (res.statusCode == 200) {
      setState(() {
        statusCode = true;
      });
    }
    print(statusCode);
  }

  changePassword(String password)async{
    var res = await http.put(
      "http://${widget.lo}:3005/owner/changePassword",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': widget.email,
        'password': password
      }),
    );
    if(res.statusCode==200){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginOwner()),
      );
    }
  }
}
