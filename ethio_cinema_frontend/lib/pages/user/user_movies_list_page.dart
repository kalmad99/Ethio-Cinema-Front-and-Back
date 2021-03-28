import 'package:ethio_cinema_frontend/bloc/bloc.dart';
import 'package:ethio_cinema_frontend/models/model.dart';
import 'package:ethio_cinema_frontend/pages/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserMovieListPage extends StatefulWidget {
  @override
  _UserMovieListPageState createState() => _UserMovieListPageState();
}

class _UserMovieListPageState extends State<UserMovieListPage> {
  @override
  Widget build(BuildContext context) {
    MovieBloc movieBloc = BlocProvider.of<MovieBloc>(context);

    //List<Movies> movies = [];
    var fetcheddata = [
      {
        "title": "Cyberpunk 2077: Edgerunners",
        "time": "10:15",
        "poster": "assets/images/Cyberpunk2077.jpeg",
      },
      {
        "title": "Despicable Me 3",
        "time": "6:40",
        "poster": "assets/images/despicableme3.jpeg",
      },
      {
        "title": "Hitman",
        "time": "00:45",
        "poster": "assets/images/Hitman.jpeg",
      },
      {
        "title": "Johnny Silverhand",
        "time": "17:00",
        "poster": "assets/images/imagessilverhand.jpeg",
      },
      {
        "title": "Cyberpunk 2077: V's Redemption",
        "time": "03:55",
        "poster": "assets/images/imagesv.jpeg",
      },
      {
        "title": "Ghost of Tsushima",
        "time": "01:30",
        "poster": "assets/images/Samurai.jpeg",
      },
      {
        "title": "Batman",
        "time": "12:15",
        "poster": "assets/images/Batman.jpeg",
      },
      {
        "title": "Logan",
        "time": "08:20",
        "poster": "assets/images/Wolverine.jpeg",
      },
      {
        "title": "Spiderman: Into the Spider Verse",
        "time": "11:00",
        "poster": "assets/images/SpiderMan.jpeg",
      },
    ];
    return Scaffold(body:
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
            'Ooops!! Sorry!! No Movies Currently',
          ));
        }
        return Container(
          padding: const EdgeInsets.all(10.0),
          child: _buildmovies(movies),
        );
      }
      return Center(child: CircularProgressIndicator());
    }));
  }

  GridView _buildmovies(fetcheddata) {
    return GridView.builder(
      itemCount: fetcheddata.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
      itemBuilder: (context, index) {
        return SingleMovieCard(movie: fetcheddata[index]);

        /*ListTile(
          title: Text("this is the shit"),
          subtitle: Text("trial $index"),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image(image: AssetImage("assets/angry.jpg"),height: 150,),
          ),
          onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage(image: "assets/angry.jpg", index: index,)));},
        );*/
      },
    );
  }
}

class SingleMovieCard extends StatelessWidget {
  final Movie movie;
  SingleMovieCard({this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: movie.title,
        child: Material(
          child: InkWell(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(UserMovieDetail.routeName, arguments: movie);
            },
            child: GridTile(
              footer: Container(
                color: Colors.white70,
                child: ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 8.0, 50.0, 8.0),
                    child: Text(
                      movie.title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                  trailing: Text("IMDBRating: ${movie.rating.toString()}"),
                ),
              ),
              child: Image(
                image: AssetImage(movie.image == ""
                    ? "assets/images/Batman.jpeg"
                    : movie.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
