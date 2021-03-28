import 'package:ethio_cinema_frontend/bloc/bloc.dart';
import 'package:ethio_cinema_frontend/models/cinema.dart';
import 'package:ethio_cinema_frontend/models/model.dart';
import 'package:ethio_cinema_frontend/pages/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCinemaSchedule extends StatefulWidget {
  static const routeName = 'UserCinemaSchedule';

  final Cinema cinema;

  UserCinemaSchedule({this.cinema});

  @override
  _UserCinemaScheduleState createState() => _UserCinemaScheduleState();
}

class _UserCinemaScheduleState extends State<UserCinemaSchedule>
    with SingleTickerProviderStateMixin {
  TabController _UserCinemaScheduleController;

  @override
  void initState() {
    super.initState();
    _UserCinemaScheduleController =
        TabController(length: 7, vsync: this, initialIndex: 0);
  }

  List<String> movies = ["Avengers", "MUkera", "Sereyet", "measbeyalesh man"];
  List<String> movies2 = [];
  List<String> movies3 = ["Avengers", "MUkera", "Sereyet"];
  List<String> movies4 = ["Avengers", "Sereyet"];
  @override
  Widget build(BuildContext context) {
    //ScheduleBloc scheduleBloc = BlocProvider.of<ScheduleBloc>(context);
    BlocProvider.of<ScheduleBloc>(context)
        .add(ScheduleLoadByCinemaID(widget.cinema.id));
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: const Color(0xffdedede),
        title: Text(
          widget.cinema.name,
          style: TextStyle(
            color: const Color(0xff13c7ff),
          ),
        ),
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(30.0),
          child: TabBar(
            isScrollable: true,
            unselectedLabelColor: const Color(0xff13c7ff),
            labelColor: const Color(0xff13c7ff),
            indicatorColor: const Color(0xff13c7ff),
            tabs: [
              Tab(
                child: Text("MONDAY"),
              ),
              Tab(
                child: Text("TEUSDAY"),
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
            controller: _UserCinemaScheduleController,
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
            return TabBarView(
              children: [
                _buildUserCinemaSchedule("Monday", schedules),
                _buildUserCinemaSchedule("Tuesday", schedules),
                _buildUserCinemaSchedule("Wedenesday", schedules),
                _buildUserCinemaSchedule("Thursday", schedules),
                _buildUserCinemaSchedule("Friday", schedules),
                _buildUserCinemaSchedule("Saturday", schedules),
                _buildUserCinemaSchedule("Sunday", schedules),
              ],
              controller: _UserCinemaScheduleController,
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildUserCinemaSchedule(String weekday, List<Schedule> schedules) {
    List<Movie> moviesForID;
    Movie scheduledMovie;

    schedules = schedules
        .where((schedule) => schedule.day
            .toLowerCase()
            .contains(weekday.toString().toLowerCase()))
        .toList();
    if (schedules.length == 0) {
      return Center(child: Text("No Movies in this Date"));
    }

    return ListView.builder(
        itemCount: schedules.length,
        itemBuilder: (context, index) {
          ScheduleEvent getSingleMovieEvent =
              SinleMovieFetchEvent(schedules[index]);
          BlocProvider.of<ScheduleBloc>(context).add(getSingleMovieEvent);

          return ListTile(
              title: BlocBuilder<MovieBloc, MovieState>(
                builder: (context, moviesate) {
                  if (moviesate is MovieLoadSuccess)
                    moviesForID = moviesate.movies;
                  scheduledMovie =
                      getScheduledMovie(moviesForID, schedules, index);
                  return Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      scheduledMovie == null ? "" : scheduledMovie.title,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text("Showing Time: "),
                      Text(
                        schedules[index].starttime,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text("Date: "),
                      Text(
                        schedules[index].day,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text("Normal Price: "),
                      Text(
                        widget.cinema.price.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text("VIP Price: "),
                      Text(
                        widget.cinema.vipprice.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
              leading: Icon(
                Icons.movie,
                size: 100,
                color: const Color(0xff13c7ff),
              ),

              // onTap: () => Navigator.of(context).push(
              //     MaterialPageRoute(builder: (context) => (BookingPage())))
              onTap: () {
                Navigator.of(context).pushNamed(BookingPage.routeName);
              });
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
}
