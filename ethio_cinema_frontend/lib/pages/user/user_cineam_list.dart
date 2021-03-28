import 'package:ethio_cinema_frontend/bloc/bloc.dart';
import 'package:ethio_cinema_frontend/models/cinema.dart';
import 'package:ethio_cinema_frontend/pages/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCinemaList extends StatefulWidget {
  UserCinemaList({Key key}) : super(key: key);
  static const routeName = '/Cinemas';

  @override
  _UserCinemaListState createState() => _UserCinemaListState();
}

class _UserCinemaListState extends State<UserCinemaList> {
  // var itemtoadd = {
  //   "name": "Gast Mall Cinema",
  //   "location": "Around CMC",
  //   "price2d": 70,
  //   "price3d": 100,
  //   "seats": 150,
  // };

  // Cinema cinematoadd = new Cinema(
  //     name: "Gast Mall Cinema",
  //     location: "Around CMC",
  //     seats: 150,
  //     price2d: 70,
  //     price3d: 100);

  // String cinemasstring =
  //     "[{'name': 'Century Cineplex','location': 'Around Gurdshola','price2d': 80,'price3d': 100,'seats': 150} , {'name': 'Edna Mall Cinema','location': 'Bole Mehanialem','price2d': 100,'price3d': 130,'seats': 100} , {'name': 'Biresh Cineplus','location': 'Eliana Mall','price2d': 60,'price3d': 100,'seats': 80}]";

  // List<Cinema> cinemaslist = [
  //   new Cinema(
  //       name: "Century Cineplex",
  //       location: "Around Gurdshola",
  //       seats: 80,
  //       price2d: 100,
  //       price3d: 150),
  //   new Cinema(
  //       name: "Edna Mall Cinema",
  //       location: "Bole Mehanialem",
  //       seats: 100,
  //       price2d: 130,
  //       price3d: 100),
  //   new Cinema(
  //       name: "Biresh Cineplusx",
  //       location: "Eliana Mall",
  //       seats: 80,
  //       price2d: 60,
  //       price3d: 100)
  // ];

  @override
  Widget build(BuildContext context) {
    //   var cinemasfromJSON = getCinemaList(cinemasstring.replaceAll("'", "\""));
    CinemaBloc cinemaBloc = BlocProvider.of<CinemaBloc>(context);

    //print(cinemaslist);

    return Scaffold(
      body: Container(
        child: BlocBuilder<CinemaBloc, CinemaState>(
          builder: (context, cinemastate) {
            if (cinemastate is CinemaOpFailure) {
              return Center(
                  child: Text(
                'Could not do Cinema operation',
                style: TextStyle(color: Colors.redAccent),
              ));
            }
            if (cinemastate is CinemaLoadSuccess) {
              final cinemas = cinemastate.cinemas;
              return _buildcinemaslist(cinemas);
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  ListView _buildcinemaslist(List<Cinema> cinemas) {
    return ListView.builder(
        itemCount: cinemas.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              "${cinemas[index].name}",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            subtitle: Text("Price: " + cinemas[index].price.toString()),
            leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.theaters,
                  size: 40,
                )),
            // onTap: () => Navigator.of(context)
            //     .pushNamed(CinemaDetail.routeName, arguments: cinemas[index]),

            onTap: () => Navigator.of(context).pushNamed(
                UserCinemaSchedule.routeName,
                arguments: cinemas[index]),
          );
        });
  }

  // List<Cinema> getCinemaList(String data) {
  //   List<dynamic> bdy = jsonDecode(data);

  //   List<Cinema> cinemas =
  //       bdy.map((dynamic item) => Cinema.fromJson(item)).toList();

  //   return cinemas;
}
