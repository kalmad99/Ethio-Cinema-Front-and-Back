import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ethio_cinema_frontend/bloc/bloc.dart';
import 'package:ethio_cinema_frontend/models/model.dart';
import 'package:ethio_cinema_frontend/pages//screen.dart';

class MoviesListPage extends StatefulWidget {
  MoviesListPage({Key key}) : super(key: key);
  static const routeName = '/Movies';

  @override
  _MoviesListPageState createState() => _MoviesListPageState();
}

class _MoviesListPageState extends State<MoviesListPage> {
  @override
  Widget build(BuildContext context) {
    MovieBloc movieBloc = BlocProvider.of<MovieBloc>(context);

    return Scaffold(
      body: Container(child:
          BlocBuilder<MovieBloc, MovieState>(builder: (context, moviestate) {
        if (moviestate is MovieOperationFailure) {
          return Center(
              child: Text(
            'Could not do Movie operation',
            style: TextStyle(color: Colors.redAccent),
          ));
        }
        if (moviestate is MovieLoadSuccess) {
          final movies = moviestate.movies;
          if (movies.length == 0) {
            return Center(
                child: Text(
              'No Movies Currently. Press on "+" to add movies ',
            ));
          }
          return _buildmovieslist(movies, movieBloc);
        }

        return Center(child: CircularProgressIndicator());
      })),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(AddMovie.routeName);
        },
      ),
    );
  }

  ListView _buildmovieslist(List<Movie> movies, MovieBloc _moviebloc) {
    return ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              "${movies[index].title}",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            subtitle: Text("Rating: " + movies[index].rating.toString()),
            leading: Padding(
                padding: const EdgeInsets.all(8.0), child: Icon(Icons.movie)),
            trailing: Container(
              width: 100,
              child: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  return (showDialog(
                        context: context,
                        builder: (context) => new AlertDialog(
                          title: new Text('Are you sure?'),
                          content:
                              new Text('Do you want to delete this Entry?'),
                          actions: <Widget>[
                            new FlatButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: new Text('No'),
                            ),
                            new FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop(false);
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          content: Text(
                                              "Movie Successfuly Deleted "),
                                          actions: [
                                            FlatButton(
                                              child: Text("OK"),
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(false),
                                            )
                                          ],
                                        ));

                                _moviebloc.add(MovieDelete(movies[index]));
                              },
                              child: new Text('Yes'),
                            ),
                          ],
                        ),
                      )) ??
                      false;
                  //print(cinemaslist);
                },
              ),
            ),
            onTap: () => Navigator.of(context)
                .pushNamed(MovieDetails.routeName, arguments: movies[index]),
          );
        });
  }
}
