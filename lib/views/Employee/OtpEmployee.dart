// ignore: must_be_immutable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/views/Employee/SignupEmployee.dart';

// ignore: must_be_immutable
class OtpEmployee extends StatefulWidget {
  String value;
  OtpEmployee({this.value});
  @override
  _OtpEmployeeState createState() => _OtpEmployeeState(value);
}

class _OtpEmployeeState extends State<OtpEmployee> {
  bool _isLoading = false;
  String value;
  String phone;
  _OtpEmployeeState(this.value);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    phone = value;
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP verification"),
      ),
      body: Container(
        color: Colors.teal,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  SizedBox(height: 160,),
                  textSection(),
                  buttonSection(),
                ],
              ),
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
        onPressed: otpController == ""
            ? null
            : () {
                setState(() {
                  _isLoading = true;
                });
                getOTP(otpController.text);
              },
        elevation: 0.0,
        color: Colors.purple,
        child: Text("Verify", style: TextStyle(color: Colors.white70)),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(500.0)),
      ),
    );
  }

  final TextEditingController otpController = new TextEditingController();

  getOTP(String otp) async {
    if (otp == "123") {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) => SignUpEmployee(phonee: phone)),
          (Route<dynamic> route) => false);
    }
  }

  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 30.0),
          TextFormField(
            controller: otpController,
            cursorColor: Colors.white,
            obscureText: true,
            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              icon: Icon(Icons.phone, color: Colors.white70),
              hintText: "OTP",
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
