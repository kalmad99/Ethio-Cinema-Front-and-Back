import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  static const String routeName = "aboutUs";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "About Us",
          style: TextStyle(fontSize: 72.0),
        ),
      ),
    );
  }
}
