import 'package:a2z_qr/scan.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("A2z Ticketing"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image(image: AssetImage('assets/images/homepage.png')),
            SizedBox(
              height: 20.0,
            ),
            flatButon("Scan QR Code", Scan()),
          ],
        ),
      ),
    );
  }

  Widget flatButon(String text, Widget widget) {
    return FlatButton(
      padding: EdgeInsets.all(20.0),
      child: Text(text),
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => widget));
      },
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: BorderSide(color: Colors.blue, width: 1.0)),
    );
  }
}
