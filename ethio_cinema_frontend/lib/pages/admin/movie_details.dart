import 'package:flutter/material.dart';

import 'package:ethio_cinema_frontend/models/model.dart';
import 'package:ethio_cinema_frontend/pages/screen.dart';

class MovieDetails extends StatelessWidget {
  static const routeName = 'movieDetail';

  final Movie movie;

  MovieDetails({this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Admin/Movies/${movie.title}")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Stack(children: [
                Container(
                    color: Colors.black,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Center(
                        child: Icon(
                          Icons.movie,
                          color: Colors.white,
                          size: 150,
                          //     Image(
                          //   image: AssetImage(poster),
                          //   height: 300,
                          //   fit: BoxFit.fitWidth,
                          // )
                        ),
                      ),
                    ))
              ]),
              SizedBox(
                height: 30,
              ),
              Text(
                movie.title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontStyle: FontStyle.italic),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        "Release Year",
                        style: TextStyle(color: Colors.black26),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${movie.release_date}",
                        style: TextStyle(
                            color: Colors.black26, fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "IMDB Rating",
                        style: TextStyle(color: Colors.black26),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${movie.rating}/10",
                        style: TextStyle(
                            color: Colors.black26, fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Text(
                  "${movie.overview}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.0,
                    wordSpacing: 5,
                    letterSpacing: 2,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        child: MaterialButton(
                          onPressed: () => Navigator.of(context)
                              .pushNamed(EditMovie.routeName, arguments: movie),
                          textColor: Colors.white,
                          child: Text("EDIT"),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
