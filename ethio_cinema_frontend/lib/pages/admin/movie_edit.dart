import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ethio_cinema_frontend/bloc/bloc.dart';
import 'package:ethio_cinema_frontend/models/model.dart';
import 'package:ethio_cinema_frontend/pages/screen.dart';

class EditMovie extends StatefulWidget {
  static const routeName = 'updateMovie';

  final Movie movie;

  const EditMovie({this.movie});

  @override
  _EditMovieState createState() => _EditMovieState();
}

class _EditMovieState extends State<EditMovie> {
  final TextEditingController _movieTitleEditingController =
      new TextEditingController();

  final TextEditingController _movieReleaseDateEditingController =
      new TextEditingController();

  final TextEditingController _movieRatingEditingController =
      new TextEditingController();

  final TextEditingController _movieOverviewEditingController =
      new TextEditingController();

  String movietitle = "";
  String moviereleasedate = "";
  String movierating = "";
  String movieoverview = "";

  @override
  void initState() {
    super.initState();

    _movieTitleEditingController.value =
        TextEditingValue(text: widget.movie.title);

    _movieReleaseDateEditingController.value =
        TextEditingValue(text: widget.movie.release_date);

    _movieRatingEditingController.value =
        TextEditingValue(text: widget.movie.rating.toString());

    _movieOverviewEditingController.value =
        TextEditingValue(text: widget.movie.overview.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe8e8e8),
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Admin/Movies/${widget.movie.title}"),
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
                  controller: _movieTitleEditingController,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 15),
                      border: InputBorder.none,
                      labelText: "Movie Ttile",
                      contentPadding: EdgeInsets.fromLTRB(50, 5, 0, 0)),
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
                  controller: _movieReleaseDateEditingController,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 15),
                      labelText: "Movie Release Year",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(50, 5, 0, 0)),
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
                  controller: _movieRatingEditingController,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 15),
                      labelText: "Movie IMDB Rating",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(50, 5, 0, 0)),
                  onChanged: (value) {
                    movierating = value;
                  },
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 100,
                // width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                    color: const Color(0xffffffff),
                    borderRadius: BorderRadius.circular(10)),
                child: Flexible(
                  child: TextField(
                    controller: _movieOverviewEditingController,
                    decoration: InputDecoration(
                        hintStyle: TextStyle(fontSize: 15),
                        labelText: "Movie Overview",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.fromLTRB(50, 5, 0, 0)),
                    onChanged: (value) {
                      movieoverview = value;
                    },
                  ),
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
                          MovieEvent updateEvent = MovieUpdate(Movie(
                              id: widget.movie.id,
                              title: movietitle == ""
                                  ? widget.movie.title
                                  : movietitle,
                              image: "",
                              release_date: moviereleasedate == ""
                                  ? widget.movie.release_date
                                  : moviereleasedate,
                              rating: movierating == ""
                                  ? widget.movie.rating
                                  : double.parse(movierating),
                              overview: movieoverview == ""
                                  ? widget.movie.overview
                                  : movieoverview));
                          BlocProvider.of<MovieBloc>(context).add(updateEvent);
                          return showDialog(
                              context: context,
                              child: AlertDialog(
                                content: Text("Movie Successfully Updated"),
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
                        child: Text("DONE"),
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
