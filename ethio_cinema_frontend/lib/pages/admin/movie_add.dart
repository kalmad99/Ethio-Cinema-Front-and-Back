import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ethio_cinema_frontend/bloc/bloc.dart';
import 'package:ethio_cinema_frontend/models/model.dart';
import 'package:ethio_cinema_frontend/pages/screen.dart';

class AddMovie extends StatefulWidget {
  static const String routeName = "addMovie";
  @override
  _AddMovieState createState() => _AddMovieState();
}

class _AddMovieState extends State<AddMovie> {
  Movie movie;

  String movietitle = "";
  String moviereleasedate = "";
  String movierating = "";
  String movieoverview = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe8e8e8),
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(title: Text("Admin/Movies/AddMovie")),
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
                      hintText: "Movie Title",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(50, 0, 0, 0)),
                  onChanged: (value) {
                    movietitle = value;
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
                      hintText: "Movie Release Year",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(50, 0, 0, 0)),
                  onChanged: (value) {
                    moviereleasedate = value;
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
                  decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 15),
                      hintText: "Movie Raing",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(50, 0, 0, 0)),
                  onChanged: (value) {
                    movierating = value;
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
                  decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 15),
                      hintText: "Overview",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(50, 0, 0, 0)),
                  onChanged: (value) {
                    movieoverview = value;
                  },
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
                          MovieEvent updateEvent = MovieCreate(Movie(
                            title: movietitle,
                            release_date: moviereleasedate,
                            rating: double.parse(movierating),
                            overview: movieoverview,
                            image: "",
                          ));
                          BlocProvider.of<MovieBloc>(context).add(updateEvent);
                          return showDialog(
                              context: context,
                              child: AlertDialog(
                                content: Text("Movie Successfully Added"),
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

  void addMovie(String name, String location, String seats, String price2d,
      String price3d) {}
}
