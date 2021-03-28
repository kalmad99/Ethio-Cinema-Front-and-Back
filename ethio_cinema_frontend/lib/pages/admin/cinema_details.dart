import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ethio_cinema_frontend/bloc/bloc.dart';
import 'package:ethio_cinema_frontend/models/model.dart';
import 'package:ethio_cinema_frontend/pages/screen.dart';

class CinemaDetail extends StatefulWidget {
  static const routeName = 'cinemaDetail';

  final Cinema cinema;

  const CinemaDetail({this.cinema});

  @override
  _CinemaDetailState createState() => _CinemaDetailState();
}

class _CinemaDetailState extends State<CinemaDetail> {

  final TextEditingController _cinemaNameEditingController =
      new TextEditingController();

  final TextEditingController _cinemaCapacityEditingController =
      new TextEditingController();

  final TextEditingController _cinemaVIPCapacityEditingController =
      new TextEditingController();

  final TextEditingController _cinemaPriceEditingController =
      new TextEditingController();

  final TextEditingController _cinemaVIPPriceEditingController =
      new TextEditingController();

  String cinemaname = "";
  String cinemacapacity = "";
  String cinemaVIPCapacity = "";
  String cinemaPrice = "";
  String cinemaVIPPrice = "";

  @override
  void initState() {
    super.initState();

    _cinemaNameEditingController.value =
        TextEditingValue(text: widget.cinema.name);

    _cinemaCapacityEditingController.value =
        TextEditingValue(text: widget.cinema.capacity.toString());

    _cinemaVIPCapacityEditingController.value =
        TextEditingValue(text: widget.cinema.vipcapacity.toString());

    _cinemaPriceEditingController.value =
        TextEditingValue(text: widget.cinema.price.toString());

    _cinemaVIPPriceEditingController.value =
        TextEditingValue(text: widget.cinema.vipprice.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe8e8e8),
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Admin/Cinemas/${widget.cinema.name}"),
      ),
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
                  controller: _cinemaNameEditingController,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 15),
                      labelText: "Cinema Name",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(50, 5, 0, 0)),
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
                  controller: _cinemaCapacityEditingController,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 15),
                      labelText: "Cinema Capacity",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(50, 5, 0, 0)),
                  onChanged: (value) {
                    cinemacapacity = value;
                  },
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                    color: const Color(0xffffffff),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: _cinemaVIPCapacityEditingController,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 15),
                      labelText: "Number of VIP Seats",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(50, 5, 0, 0)),
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
                  controller: _cinemaPriceEditingController,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 15),
                      labelText: "Price",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(50, 5, 0, 0)),
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
                  controller: _cinemaVIPPriceEditingController,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 15),
                      labelText: "VIP Price",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(50, 5, 0, 0)),
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
                          CinemaEvent updateEvent = CinemaUpdate(Cinema(
                            id: widget.cinema.id,
                            name: cinemaname == ""
                                ? widget.cinema.name
                                : cinemaname,
                            capacity: cinemacapacity == ""
                                ? widget.cinema.capacity
                                : int.parse(cinemacapacity),
                            vipcapacity: cinemaVIPCapacity == ""
                                ? widget.cinema.vipcapacity
                                : int.parse(cinemaVIPCapacity),
                            price: cinemaPrice == ""
                                ? widget.cinema.price
                                : int.parse(cinemaPrice),
                            vipprice: cinemaVIPPrice == ""
                                ? widget.cinema.vipprice
                                : int.parse(cinemaVIPPrice),
                          ));
                          BlocProvider.of<CinemaBloc>(context).add(updateEvent);
                          return showDialog(
                              context: context,
                              child: AlertDialog(
                                content: Text("Cinema Successfully Updated"),
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
                        child: Text("EDIT"),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10)),
                          child: MaterialButton(
                            onPressed: () {
                              // Navigator.of(context).pushNamed(
                              //     CinemaSchedule.routeName,
                              //     arguments: widget.cinema);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => (CinemaSchedule(
                                        cinema: widget.cinema,
                                      ))));
                            },
                            textColor: Colors.white,
                            child: Text("GO TO SCHEDULE"),
                          )))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

//  void addCinema(String name, String location, String seats, String price2d,
//      String price3d) {}
  void addCinema(String name, String capacity, String vipcapacity, String price,
      String vipprice) {}
}
