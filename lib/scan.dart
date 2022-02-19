import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';

class Scan extends StatefulWidget {
  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  String qrResult = "Not Yet Scanned";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan QR"),
        centerTitle: true,
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
            // Expanded(
            //   child: Divider(
            //     color: Colors.black,
            //     // height: 0.1,
            //   ),
            // ),
            Text(
              qrResult,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(
              height: 20.0,
            ),
            FloatingActionButton.extended(
                icon: Icon(Icons.camera_alt),
                label: Text("Scan"),
                onPressed: () async {
                  String a2zScan = (await BarcodeScanner.scan()) as String;
                  setState(() {
                    qrResult = a2zScan;
                  });
                }),
          ],
        ),
      ),
    );
  }
}
