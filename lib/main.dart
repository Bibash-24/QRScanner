import 'dart:convert';

import 'package:a2z_qr/utilities/constants.dart';
import 'package:a2z_qr/utilities/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:a2z_qr/homepage.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String eventsID;
  String pinCode;

  signIn(eventsID, pinCode) async {
    final Map<String, dynamic> signInData = {
      eventsID: "string",
      pinCode: "string"
    };

    var response = await http.post(
      Uri.parse("https://api.a2zticketing.com/api/pinCode"),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      body: json.encode(signInData),
    );

    var jsonResponse = json.decode(response.body);
    final Map<String, dynamic> responseData = json.decode(jsonResponse);

    if (responseData['status'] != 'error') {
      // setState(() {
      //   _isLoading = false;
      // });

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Homepage()));
      AlertDialog alert = AlertDialog(
        title: CustomText(
          text: "Success",
          size: 15,
        ),
        content: CustomText(
          text: responseData['result'],
          size: 12,
        ),
      );

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    } else {
      // setState(() {
      //   _isLoading = false;
      // });
      AlertDialog alert = AlertDialog(
        title: CustomText(
          text: "Error",
          size: 15,
        ),
        content: CustomText(
          text: responseData['result'],
          size: 12,
        ),
      );

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }

  bool _remeberMe = false;

  TextEditingController eventIDcontroller = new TextEditingController();
  TextEditingController eventPINcontroller = new TextEditingController();

  Widget _buildEventIDForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Event ID',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: eventIDcontroller,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.event,
                color: Colors.white,
              ),
              hintText: 'Enter your Event-ID',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEventPinForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'PIN Code',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: eventPINcontroller,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter your PIN Code',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => print("Forgot Password Button Pressed"),
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          "Forgot Password?",
          style: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildRememberMeCheckBox() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _remeberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _remeberMe = value;
                });
              },
            ),
          ),
          Text(
            "Remeber me",
            style: kLabelStyle,
          )
        ],
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          signIn(eventsID, pinCode);
        },
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => Homepage(),
        //   ),
        // ),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          "LOGIN",
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // return Homepage();
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF73AEF5),
                      Color(0xFF61A4F1),
                      Color(0xFF478DE0),
                      Color(0xFF398AE5),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding:
                      EdgeInsets.symmetric(horizontal: 40.0, vertical: 120.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Sign In",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 30.0),
                      _buildEventIDForm(),
                      SizedBox(height: 30.0),
                      _buildEventPinForm(),
                      _buildForgotPasswordBtn(),
                      _buildRememberMeCheckBox(),
                      _buildLoginBtn(),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: "Don\'t have an account? Contact Us",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                              ))
                        ]),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
