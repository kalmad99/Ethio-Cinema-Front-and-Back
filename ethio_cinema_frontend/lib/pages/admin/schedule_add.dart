import 'package:ethio_cinema_frontend/bloc/bloc.dart';
import 'package:ethio_cinema_frontend/models/cinema.dart';
import 'package:ethio_cinema_frontend/models/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleAdd extends StatefulWidget {
  static const routeName = 'addSchedule';

  final Cinema cinema;

  ScheduleAdd({this.cinema});

  @override
  _ScheduleAddState createState() => _ScheduleAddState();
}

class _ScheduleAddState extends State<ScheduleAdd> {
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

  List<String> weekdays = [
    "Monday",
    "Tuesday",
    "Wedenesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];

  Movie _selectedMovie;

  String _showingTime = "";
  String _date = "";
  String _dateOfWeek = "";
  String _dimension = "";

  @override
  Widget build(BuildContext context) {
    //MovieBloc movieBloc = BlocProvider.of<MovieBloc>(context);

    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text("${widget.cinema.name}/addSchedule")),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      onPressed: () {
                        return (showDialog(
                          context: context,
                          builder: (context) => new AlertDialog(
                            title: new Text(
                              'Movies',
                            ),
                            content: BlocBuilder<MovieBloc, MovieState>(
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
                                return _buildmovieslist(movies);
                              }

                              return Center(child: CircularProgressIndicator());
                            }),
                          ),
                        ));
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Text("Movies:"),
                          ),
                          Row(
                            children: [
                              Text(_selectedMovie == null
                                  ? ""
                                  : "${_selectedMovie.title}"),
                              Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      onPressed: () {
                        return _selectShowingTime(context);
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Text("Showing Time:"),
                          ),
                          Row(
                            children: [
                              Text("$_showingTime"),
                              Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      onPressed: () {
                        return _selectDate(context);
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Text("Date:"),
                          ),
                          Row(
                            children: [
                              Text("$_dateOfWeek $_date"),
                              Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      onPressed: () {
                        return (showDialog(
                          context: context,
                          builder: (context) => new AlertDialog(
                              title: new Text('Dimension'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    title: Text("2D"),
                                    onTap: () {
                                      setDimension("2D");
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  ListTile(
                                    title: Text("3D"),
                                    onTap: () {
                                      setDimension("3D");
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              )),
                        ));
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Text("Dimension:"),
                          ),
                          Row(
                            children: [
                              Text("$_dimension"),
                              Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 30,
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
                          ScheduleEvent addedEvent = ScheduleCreate(Schedule(
                              cinemaid: widget.cinema.id,
                              starttime: _showingTime,
                              day: "$_dateOfWeek $_date",
                              booked: 0,
                              movieid: _selectedMovie.id,
                              dimension: _dimension));
                          BlocProvider.of<ScheduleBloc>(context)
                              .add(addedEvent);
                          return showDialog(
                              context: context,
                              child: AlertDialog(
                                title: Text("Schedule Successfully Created"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      leading: Text("Cinema:"),
                                      trailing: Text(widget.cinema.name),
                                    ),
                                    ListTile(
                                      leading: Text("Movie:"),
                                      trailing: Text(_selectedMovie.title),
                                    ),
                                    ListTile(
                                      leading: Text("Showing Time:"),
                                      trailing: Text(_showingTime),
                                    ),
                                    ListTile(
                                      leading: Text("Date:"),
                                      trailing: Text("$_dateOfWeek $_date"),
                                    ),
                                    ListTile(
                                      leading: Text("Dimension:"),
                                      trailing: Text(_dimension),
                                    ),
                                  ],
                                ),
                                actions: [
                                  FlatButton(
                                      child: Text("OK"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      })
                                ],
                              ));
                        },
                        textColor: Colors.black45,
                        child: Text(
                          "ADD",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  ListView _buildmovieslist(List<Movie> mvs) {
    return ListView.builder(
        itemCount: mvs.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              mvs[index].title,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              setMovie(mvs[index]);
              Navigator.of(context).pop();
            },
          );
        });
  }

  ListView _buildWeekdaysList(weekdays) {
    return ListView.builder(
        itemCount: weekdays.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              weekdays[index],
              style: TextStyle(fontSize: 17),
            ),
            onTap: () {
              setDateOfWeek(weekdays[index]);
              Navigator.of(context).pop();
            },
          );
        });
  }

  Future<void> _selectShowingTime(BuildContext context) async {
    final TimeOfDay timePicked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, widget) {
          return MediaQuery(
            child: widget,
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          );
        });

    if (timePicked != null && timePicked != TimeOfDay.now()) {
      setState(() {
        _showingTime =
            "${timePicked.hour.toString()}:${timePicked.minute.toString()}";
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime datePicked = await showDatePicker(
        context: context,
        firstDate: DateTime(2020),
        lastDate: DateTime(2025),
        initialDate: DateTime.now(),
        builder: (context, widget) {
          return MediaQuery(
            child: widget,
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          );
        });

    if (datePicked != null && datePicked != DateTime.now()) {
      setState(() {
        _date = "${datePicked.day}/${datePicked.month}/${datePicked.year}";
        _dateOfWeek = "${weekdays[datePicked.weekday - 1]}";
      });
    }
  }

  void setMovie(Movie movie) {
    setState(() {
      _selectedMovie = movie;
    });
  }

  void setDimension(String dimension) {
    setState(() {
      _dimension = dimension;
    });
  }

  void setDateOfWeek(String dateOfWeek) {
    setState(() {
      _dateOfWeek = dateOfWeek;
    });
  }
}
