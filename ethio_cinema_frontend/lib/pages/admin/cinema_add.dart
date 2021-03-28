import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ethio_cinema_frontend/models/model.dart';
import 'package:ethio_cinema_frontend/bloc/bloc.dart';
import 'package:ethio_cinema_frontend/pages/screen.dart';

class AddCinema extends StatefulWidget {
  static const String routeName = "addCinema";

  //const AddCinema({this.cinema});

  @override
  _AddCinemaState createState() => _AddCinemaState();
}

class _AddCinemaState extends State<AddCinema> {
  Cinema cinema;
  String cinemaname = "";
  String cinemacapacity = "";
  String cinemaVIPCapacity = "";
  String cinemaPrice = "";
  String cinemaVIPPrice = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe8e8e8),
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(title: Text("Admin/Cinemas/AddCinema")),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: Column(
            children: [
              SizedBox(height: 80),
              Container(
                decoration: BoxDecoration(
                    color: const Color(0xffffffff),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 15),
                      hintText: "Cinema Name",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(50, 0, 0, 0)),
                  onChanged: (value) {
                    cinemaname = value;
                  },
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                    color: const Color(0xffffffff),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 15),
                      hintText: "Cinema Capacity",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(50, 0, 0, 0)),
                  onChanged: (value) {
                    cinemacapacity = value;
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                    color: const Color(0xffffffff),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 15),
                      hintText: "Number of VIP Seats",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(50, 0, 0, 0)),
                  onChanged: (value) {
                    cinemaVIPCapacity = value;
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                    color: const Color(0xffffffff),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 15),
                      hintText: "Price",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(50, 0, 0, 0)),
                  onChanged: (value) {
                    cinemaPrice = value;
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                    color: const Color(0xffffffff),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 15),
                      hintText: "VIP Price",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(50, 0, 0, 0)),
                  onChanged: (value) {
                    cinemaVIPPrice = value;
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10)),
                      child: MaterialButton(
                        onPressed: () {
                          CinemaEvent addedEvent = CinemaCreate(Cinema(
//                            name: cinemaname,
//                            location: cinemalocation,
//                            seats: int.parse(cinemaseats),
//                            price2d: int.parse(cinemaprice2d),
//                            price3d: int.parse(cinemaprice3d),
                            name: cinemaname,
                            capacity: int.parse(cinemacapacity),
                            vipcapacity: int.parse(cinemaVIPCapacity),
                            price: int.parse(cinemaPrice),
                            vipprice: int.parse(cinemaVIPPrice),
                          ));
                          BlocProvider.of<CinemaBloc>(context).add(addedEvent);
                          return showDialog(
                              context: context,
                              child: AlertDialog(
                                content: Text("Cinema Successfully Added"),
                                actions: [
                                  FlatButton(
                                      child: Text("OK"),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                                AdminMainPage.routeName,
                                                (route) => false);
                                      })
                                ],
                              ));
                        },
                        textColor: Colors.white,
                        child: Text("ADD"),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addCinema(String name, String location, String seats, String price2d,
      String price3d) {}
}
