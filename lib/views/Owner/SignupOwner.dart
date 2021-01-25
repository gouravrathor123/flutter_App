import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'SignUpSubmitOwner.dart';

// ignore: must_be_immutable
class SignUpOwner extends StatefulWidget {
  String phone;
  SignUpOwner({this.phone});
  @override
  _SignUpOwnerState createState() => _SignUpOwnerState(phone);
}

class _SignUpOwnerState extends State<SignUpOwner> {
  bool _isLoading = false;
  String phone;
  // ignore: non_constant_identifier_names
  String firstName, lastName, email, pass, dob, phonee;
  _SignUpOwnerState(this.phone);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    phonee = phone;
    return Scaffold(
      appBar: AppBar(
        title: Text("Personal Details"),
        backgroundColor: Colors.teal,
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

  final TextEditingController firstnameController = new TextEditingController();
  final TextEditingController lastnameController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController dobController = new TextEditingController();

  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 30.0),
          TextFormField(
            controller: firstnameController,
            cursorColor: Colors.white,
            onChanged: (text) {
              firstName = text;
            },
            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              icon: Icon(Icons.create, color: Colors.white70),
              hintText: "First Name",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: lastnameController,
            cursorColor: Colors.white,
            obscureText: true,
            onChanged: (text) {
              lastName = text;
            },
            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              icon: Icon(Icons.create, color: Colors.white70),
              hintText: "Last Name",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: emailController,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white70),
            onChanged: (text) {
              email = text;
            },
            decoration: InputDecoration(
              icon: Icon(Icons.email, color: Colors.white70),
              hintText: "Email",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: passwordController,
            cursorColor: Colors.white,
            obscureText: true,
            onChanged: (text) {
              pass = text;
            },
            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              helperText: "password length >= 7",
              icon: Icon(Icons.lock, color: Colors.white70),
              hintText: "Password",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: dobController,
            cursorColor: Colors.white,
            onChanged: (text) {
              dob = text;
            },
            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              icon: Icon(Icons.date_range, color: Colors.white70),
              hintText: "Date of Birth",
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
        onPressed: firstnameController == "" ||
                // ignore: unrelated_type_equality_checks
                lastnameController == "" ||
                // ignore: unrelated_type_equality_checks
                emailController == "" ||
                // ignore: unrelated_type_equality_checks
                passwordController == "" ||
                // ignore: unrelated_type_equality_checks
                dobController == ""
            ? null
            : () {
                setState(() {
                  _isLoading = true;
                });

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => SignUpSubmitOwner(
                            firstName: firstName,
                            lastName: lastName,
                            email: email,
                            pass: pass,
                            dob: dob,
                            phonee: phonee)),
                    (Route<dynamic> route) => false);
              },
        elevation: 0.0,
        color: Colors.purple,
        child: Text("Sign Up", style: TextStyle(color: Colors.white70)),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(500.0)),
      ),
    );
  }
}
