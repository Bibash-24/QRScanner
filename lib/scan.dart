import 'dart:async';
import 'dart:convert';
import 'package:a2z_qr/Model/users.dart';
import 'package:a2z_qr/Providers/user_provider.dart';
import 'package:a2z_qr/Utils/user_preferance.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Scan extends StatefulWidget {
  final User user;
  const Scan({Key key, this.user}) : super(key: key);
  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  String result = "press the camera to start the scan !";
  String ticketNumberID;
  String pinCode;

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).user;

    // Function to post QR data to Api
    Future<void> sendQRData(ticketNumberID, pinCode) async {
      try {
        ScanResult qrScanResult = await BarcodeScanner.scan();
        String qrResult = qrScanResult.rawContent;
        setState(() {
          result = qrResult;
        });
        Map<String, dynamic> jsonData = {
          "mode": "checkedIn",
          "data": {
            "ticketNumberID": qrResult,
            "pinCode": user.pin,
            "isDelevered": 0,
            "isUsed": 0,
            "isActive": 0
          }
        };

        var response = await http.post(
            Uri.parse("https://api.a2zticketing.com/api/checkIn"),
            headers: {
              "Accept": "application/json",
              "Content-Type": "application/json",
              "Authorization": user.token,
            },
            body: json.encode(jsonData));
        // encoding: Encoding.getByName("utf-8"));

        var jsonResponse = jsonDecode(response.body);
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("${jsonDecode(jsonResponse)['result']}")));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Error sending Data")));
        }
      } on PlatformException catch (ex) {
        if (ex.code == BarcodeScanner.cameraAccessDenied) {
          setState(() {
            result = "Camera was denied";
          });
        } else {
          setState(() {
            result = "Unknown Error $ex";
          });
        }
      } on FormatException {
        setState(() {
          result = "You pressed the back button before scanning anything";
        });
      } catch (ex) {
        setState(() {
          result = "Unknown Error $ex";
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Scan QR"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {
              UserPreferences().removeUser();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "RESULT",
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              result,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(
              height: 20.0,
            ),
            FloatingActionButton.extended(
              icon: Icon(Icons.camera_alt),
              label: Text("Scan"),
              onPressed: () {
                sendQRData(ticketNumberID, pinCode);
              },
            ),
          ],
        ),
      ),
    );
  }
}
