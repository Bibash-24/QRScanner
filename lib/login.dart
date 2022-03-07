import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Model/users.dart';
import 'Providers/auth.dart';
import 'Providers/user_provider.dart';
import 'homepage.dart';
import 'utilities/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _remeberMe = false;

  var eventController = TextEditingController();
  var pinCodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // @override
    AuthProvider auth = Provider.of<AuthProvider>(context);

    // Function to call Login post Api
    Future<void> login(eventsId, pinCode) async {
      if (eventController.text.isNotEmpty &&
          pinCodeController.text.isNotEmpty) {
        final successfulMessage = auth.login(eventsId, pinCode);
        successfulMessage.then((response) {
          if (response['status']) {
            User user = response['user'];
            Provider.of<UserProvider>(context, listen: false).setUser(user);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Login Sucessful"),
              backgroundColor: Colors.greenAccent,
            ));
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Homepage()));
            // return Homepage();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Invalid Credentials"),
              backgroundColor: Colors.redAccent,
            ));
            // return 0;
          }
        });
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Blank Field Not Allowed")));
        // return 0;
      }
    }

    return Scaffold(
      body: Stack(
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
              padding: EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 120.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Event ID',
                        style: kLabelStyle,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        decoration: kBoxDecorationStyle,
                        height: 60.0,
                        child: TextField(
                          controller: eventController,
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
                            hintText: 'Enter your Event ID',
                            hintStyle: kHintTextStyle,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Event PIN Code',
                            style: kLabelStyle,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: kBoxDecorationStyle,
                            height: 60.0,
                            child: TextField(
                              controller: pinCodeController,
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
                          SizedBox(
                            height: 30.0,
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: FlatButton(
                              onPressed: () =>
                                  print("Forgot Password Button Pressed"),
                              padding: EdgeInsets.only(right: 0.0),
                              child: Text(
                                "Forgot Password?",
                                style: kLabelStyle,
                              ),
                            ),
                          ),
                          Container(
                            height: 20.0,
                            child: Row(
                              children: <Widget>[
                                Theme(
                                  data: ThemeData(
                                      unselectedWidgetColor: Colors.white),
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
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 25.0),
                            width: double.infinity,
                            child: RaisedButton(
                              elevation: 5.0,
                              onPressed: () {
                                login(
                                  eventController.text,
                                  pinCodeController.text,
                                );
                              },
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
                          ),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () => print('Contact Us button pressed'),
                              child: Center(
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Don\'t have an account? ",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "Contact Us",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
