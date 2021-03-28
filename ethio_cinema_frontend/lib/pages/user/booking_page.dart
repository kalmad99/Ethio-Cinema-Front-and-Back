import 'package:flutter/material.dart';

class BookingPage extends StatefulWidget {
  BookingPage({Key key}) : super(key: key);

  static const routeName = 'bookMovie';

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Book Now",
          style: TextStyle(fontSize: 72),
        ),
      ),
    );
  }
}
