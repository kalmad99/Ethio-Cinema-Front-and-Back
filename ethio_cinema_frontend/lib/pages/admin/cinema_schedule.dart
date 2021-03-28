import 'package:ethio_cinema_frontend/bloc/bloc.dart';
import 'package:ethio_cinema_frontend/models/model.dart';
import 'package:ethio_cinema_frontend/pages/ethio_cinema_app_routes.dart';
import 'package:flutter/material.dart';
import 'package:ethio_cinema_frontend/pages/screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CinemaSchedule extends StatefulWidget {
  static const routeName = 'cinemaSchedule';

  final Cinema cinema;

  CinemaSchedule({this.cinema});

  @override
  _CinemaScheduleState createState() => _CinemaScheduleState();
}

class _CinemaScheduleState extends State<CinemaSchedule>
    with SingleTickerProviderStateMixin {
  TabController _cinemaScheduleController;

  @override
  void initState() {
    super.initState();
    _cinemaScheduleController =
        TabController(length: 7, vsync: this, initialIndex: 0);
  }

  List<String> movies2 = [];
  List<String> movies3 = ["Avengers", "MUkera", "Sereyet"];
  List<String> movies4 = ["Avengers", "Sereyet"];
  @override
  Widget build(BuildContext context) {
    ScheduleBloc scheduleBloc = BlocProvider.of<ScheduleBloc>(context);
    BlocProvider.of<ScheduleBloc>(context)
        .add(ScheduleLoadByCinemaID(widget.cinema.id));

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.cinema.name),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(30.0),
            child: TabBar(
              isScrollable: true,
              unselectedLabelColor: Colors.white30,
              tabs: [
                Tab(
                  child: Text("MONDAY"),
                ),
                Tab(
                  child: Text("TUESDAY"),
                ),
                Tab(
                  child: Text("WEDENESDAY"),
                ),
                Tab(
                  child: Text("THURSDAY"),
                ),
                Tab(
                  child: Text("FRIDAY"),
                ),
                Tab(
                  child: Text("SATURDAY"),
                ),
                Tab(
                  child: Text("SUNDAY"),
                ),
              ],
              controller: _cinemaScheduleController,
            ),
          ),
        ),
        body: BlocBuilder<ScheduleBloc, ScheduleState>(
            builder: (context, schedulestate) {
          if (schedulestate is ScheduleOperationFailure) {
            return Center(
                child: Text(
              'Could not do Schedule operation',
              style: TextStyle(color: Colors.redAccent),
            ));
          }
          if (schedulestate is ScheduleLoadByCinemaSuccess) {
            final schedules = schedulestate.schedules;
            // .where((schedules) => schedules.cinemaid == widget.cinema.id)
            // .toList();

            return Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: TabBarView(
                children: [
                  _buildCinemaSchedule("Monday", scheduleBloc, context,
                      schedules, widget.cinema),
                  _buildCinemaSchedule("Tuesday", scheduleBloc, context,
                      schedules, widget.cinema),
                  _buildCinemaSchedule("Wedenesday", scheduleBloc, context,
                      schedules, widget.cinema),
                  _buildCinemaSchedule("Thursday", scheduleBloc, context,
                      schedules, widget.cinema),
                  _buildCinemaSchedule("Friday", scheduleBloc, context,
                      schedules, widget.cinema),
                  _buildCinemaSchedule("Saturday", scheduleBloc, context,
                      schedules, widget.cinema),
                  _buildCinemaSchedule("Sunday", scheduleBloc, context,
                      schedules, widget.cinema),
                ],
                controller: _cinemaScheduleController,
              ),
            );
          }
          return Center(child: Center(child: CircularProgressIndicator()));
        }),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              setState(() {
                Navigator.of(context)
                    .pushNamed(ScheduleAdd.routeName, arguments: widget.cinema);
              });
            }));
  }
}

Widget _buildCinemaSchedule(String weekday, ScheduleBloc scheduleBloc,
    BuildContext context, List<Schedule> schedules, Cinema cinema) {
  Movie scheduledMovie;

  List<Movie> moviesForID;

  schedules = schedules
      .where((schedule) =>
          schedule.day.toLowerCase().contains(weekday.toString().toLowerCase()))
      .toList();
  if (schedules.length == 0) {
    return Center(
        child: Text(
      'No Schedule available on this day. Tap "+" to add schedule ',
    ));
  }

  return Scaffold(
      body: getSchedulesByCinemaIDAndDay(
          schedules, moviesForID, scheduledMovie, scheduleBloc, cinema));
}

//     });
//     return Center(child: Text("this is going nowhere"));
//   }
// }

ListView getSchedulesByCinemaIDAndDay(
    scheduleByDayOfWeek, moviesForID, scheduledMovie, scheduleBloc, cinema) {
  return ListView.builder(
      itemCount: scheduleByDayOfWeek.length,
      itemBuilder: (context, index) {
        ScheduleEvent getSingleMovieEvent =
            SinleMovieFetchEvent(scheduleByDayOfWeek[index]);
        BlocProvider.of<ScheduleBloc>(context).add(getSingleMovieEvent);

        return ListTile(
            title: BlocBuilder<MovieBloc, MovieState>(
                builder: (context, moviestate) {
              if (moviestate is MovieLoadSuccess)
                moviesForID = moviestate.movies;
              scheduledMovie =
                  getScheduledMovie(moviesForID, scheduleByDayOfWeek, index);
              return Text(scheduledMovie == null ? "" : scheduledMovie.title);
            }),
            // child: Text(
            //   "mukera",
            //   // getScheduledMovie(moviesForID, scheduleByDayOfWeek, index) ==
            //   //         null
            //   //     ? ""
            //   //     : getScheduledMovie(moviesForID, scheduleByDayOfWeek, index)
            //   //         .title,
            // ),

            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Date: " + scheduleByDayOfWeek[index].day),
                  Text("Showing Time: " + scheduleByDayOfWeek[index].starttime),
                ],
              ),
            ),
            leading: Padding(
                padding: const EdgeInsets.all(8.0), child: Icon(Icons.movie)),
            trailing: Padding(
                padding: const EdgeInsets.all(8.0),
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
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: new Text('No'),
                              ),
                              new FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            content: Text(
                                                "Schedule Successfuly Removed "),
                                            actions: [
                                              FlatButton(
                                                child: Text("OK"),
                                                onPressed: () =>
                                                    Navigator.of(context)
                                                        .pop(false),
                                              )
                                            ],
                                          ));

                                  scheduleBloc.add(ScheduleDelete(
                                      scheduleByDayOfWeek[index]));
                                },
                                child: new Text('Yes'),
                              ),
                            ],
                          ),
                        )) ??
                        false;
                    // setState(() {
                    //   scheduleByDayOfWeek
                    //       .remove(scheduleByDayOfWeek[index]);
                    // });
                  },
                )),
            onTap: () => Navigator.of(context).pushNamed(
                  ScheduleEdit.routeName,
                  arguments: ScheduleEditArguments(
                    cinema: cinema,
                    movie: scheduledMovie,
                    schedule: scheduleByDayOfWeek[index],
                  ),
                ));
      });
}

Movie getScheduledMovie(List<Movie> mvs, List<Schedule> schdls, int index) {
  for (var item in mvs) {
    if (item.id == schdls[index].movieid) {
      return item;
    }
  }
  return null;
}
