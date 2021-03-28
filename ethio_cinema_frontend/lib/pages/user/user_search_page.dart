import 'package:ethio_cinema_frontend/bloc/bloc.dart';
import 'package:ethio_cinema_frontend/models/model.dart';
import 'package:ethio_cinema_frontend/pages/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Movie> filteredmovies = [];
  List<Movie> fetchedDataFromAPI = [];

  //Movie movies = new Movie();

  var fetcheddata = [
    {
      "title": "Batman",
      "time": "12:15",
      "poster": "assets/images/Batman.jpeg",
    },
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

  @override
  void initState() {
    setState(() {
      filteredmovies = fetchedDataFromAPI;
      // print(filteredmovies);
    });
    super.initState();
  }

  void filtermovies(value) {
    // print(fetcheddata.where((movies) => movies['title'] == value).toList());

    setState(() {
      filteredmovies = fetchedDataFromAPI
          .where((Movie movies) => movies.title
              .toLowerCase()
              .startsWith(value.toString().toLowerCase()))
          .toList();
      print(filteredmovies);
    });
  }

  @override
  Widget build(BuildContext context) {
    MovieBloc movieBloc = BlocProvider.of<MovieBloc>(context);

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60), child: _searchappbar()),
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, moviestate) {
          if (moviestate is MovieOperationFailure) {
            return Center(
                child: Text(
              'Could not do Movie operation',
              style: TextStyle(color: Colors.redAccent),
            ));
          }
          if (moviestate is MovieLoadSuccess) {
            final movies = moviestate.movies;
            fetchedDataFromAPI = movies;
            if (movies.length == 0) {
              return Center(
                  child: Text(
                'No Search Result',
              ));
            }
            //movies.sort();
            return Container(
              child: _buildmoviessearchlist(movies),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  ListView _buildmoviessearchlist(List<Movie> fetcheddata) {
    return ListView.builder(
      itemCount: fetcheddata.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            fetcheddata[index].title,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          subtitle: Text("IMDBRating: " + fetcheddata[index].rating.toString()),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image(
              image: AssetImage(fetcheddata[index].image == ""
                  ? "assets/images/Batman.jpeg"
                  : fetcheddata[index].image),
              height: 150,
            ),
          ),
          onTap: () {
            Navigator.of(context).pushNamed(UserMovieDetail.routeName,
                arguments: fetcheddata[index]);
          },
        );
      },
    );
  }

  AppBar _searchappbar() {
    return AppBar(
      backgroundColor: const Color(0xffdedede),
      automaticallyImplyLeading: false,
      elevation: 0,
      title: TextField(
        onChanged: (value) {
          // if (value.isEmpty) {
          //   setState(() {
          //     filteredmovies = fetchedDataFromAPI;
          //   });
          // }
          // filtermovies(value);
          BlocProvider.of<MovieBloc>(context).add(MovieSearch(value));
        },
        decoration: InputDecoration(
            hintText: "Search Movies",
            icon: Icon(Icons.search),
            hintStyle: TextStyle(color: Colors.black54)),
      ),
      actions: searchingappbar(),
      /*[
        InkWell(
          child: ShaderMask(
            child: Image(
                image: AssetImage("assets/search.png")),
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                colors: [const Color(0xff000000), const Color(0xff000000)],
              ).createShader(bounds);
            },
            blendMode: BlendMode.srcATop,
          ),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchPage())),
        ),
        InkWell(
          child: ShaderMask(
            child: Image(
                image: AssetImage("assets/my_cart.png")),
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                colors: [const Color(0xff000000), const Color(0xff000000)],
              ).createShader(bounds);
            },
            blendMode: BlendMode.srcATop,
          ),
          onTap: (){},
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0,0,15.0,0),
          child: InkWell(
            child: GestureDetector(
              child: CircleAvatar(
                backgroundColor: const Color(0xff13c7ff),
                child: Stack(
                  children: [
                    Center(child: IconButton(icon: Icon(Icons.add), onPressed: (){}))
                  ],
                ),
              ),
            ),
          ),
        )
      ],*/
    );
  }

  List<Widget> searchingappbar() {
    return [
      IconButton(
          icon: Icon(
            Icons.cancel,
            color: const Color(0xff13c7ff),
          ),
          onPressed: () => Navigator.of(context).pop())
    ];
  }
}
