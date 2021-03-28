import 'package:flutter/material.dart';

class MyBookings extends StatefulWidget {
  MyBookings({Key key}) : super(key: key);

  @override
  _MyBookingsState createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Username"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Text(
          "About Us",
          style: TextStyle(fontSize: 72.0),
        ),
      ),
    );
  }
}
