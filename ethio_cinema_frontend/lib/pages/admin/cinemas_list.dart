import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ethio_cinema_frontend/bloc/bloc.dart';
import 'package:ethio_cinema_frontend/models/model.dart';
import 'package:ethio_cinema_frontend/pages/screen.dart';

class CinemaListTrial extends StatefulWidget {
  CinemaListTrial({Key key}) : super(key: key);
  static const routeName = '/Cinemas';

  @override
  _CinemaListTrialState createState() => _CinemaListTrialState();
}

class _CinemaListTrialState extends State<CinemaListTrial> {
  @override
  Widget build(BuildContext context) {
    CinemaBloc cinemaBloc = BlocProvider.of<CinemaBloc>(context);
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
              if (cinemas.length == 0) {
                return Center(
                    child: Text(
                  'No Cinemas Added Currently. Press on "+" to add',
                ));
              }
              return _buildcinemaslist(cinemas, cinemaBloc);
            }
            return Center(child: CircularProgressIndicator());
          }),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed(AddCinema.routeName);
          },
        ));
  }

  ListView _buildcinemaslist(List<Cinema> cinemas, CinemaBloc _cinemabloc) {
    return ListView.builder(
        itemCount: cinemas.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              "${cinemas[index].name}",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            subtitle: Text("Capacity: " + cinemas[index].capacity.toString()),
            leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.theaters_rounded)),
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
                                              "Cinema Successfuly Deleted "),
                                          actions: [
                                            FlatButton(
                                              child: Text("OK"),
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(false),
                                            )
                                          ],
                                        ));

                                _cinemabloc.add(CinemaDelete(cinemas[index]));
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
                .pushNamed(CinemaDetail.routeName, arguments: cinemas[index]),
          );
        });
  }

  List<Cinema> getCinemaList(String data) {
    List<dynamic> bdy = jsonDecode(data);

    List<Cinema> cinemas =
        bdy.map((dynamic item) => Cinema.fromJson(item)).toList();

    return cinemas;
  }
}
