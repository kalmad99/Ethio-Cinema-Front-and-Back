import 'package:ethio_cinema_frontend/bloc/bloc.dart';
import 'package:ethio_cinema_frontend/models/model.dart';
import 'package:ethio_cinema_frontend/pages/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserMovieDetail extends StatefulWidget {
  static const String routeName = "userMovieDetail";

  final Movie movie;
  UserMovieDetail({
    this.movie,
  });

  @override
  _UserMovieDetailState createState() => _UserMovieDetailState();
}

class _UserMovieDetailState extends State<UserMovieDetail> {
  @override
  Widget build(BuildContext context) {
    //ScheduleBloc scheduleBloc = BlocProvider.of<ScheduleBloc>(context);
    BlocProvider.of<ScheduleBloc>(context).add(ScheduleLoad());
    //int bezat = 4;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: CustomAppBar(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
          child: Container(
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
                          child: Image(
                        image: AssetImage(widget.movie.image == ""
                            ? "assets/images/Batman.jpeg"
                            : widget.movie.image),
                        height: 300,
                        fit: BoxFit.fitWidth,
                      )),
                    ),
                  ),
                ]),
                SizedBox(
                  height: 30,
                ),
                Text(
                  widget.movie.title,
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
                          style: TextStyle(color: Colors.black54),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${widget.movie.release_date}",
                          style: TextStyle(
                              color: Colors.black54,
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "IMDB Rating",
                          style: TextStyle(color: Colors.black54),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${widget.movie.rating.toString()}/10",
                          style: TextStyle(
                              color: Colors.black54,
                              fontStyle: FontStyle.italic),
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
                    "${widget.movie.overview}",
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Currently Showing @"),
                    ),
                  ],
                ),
                Divider(
                  thickness: 2,
                  endIndent: 10,
                  indent: 10,
                ),
                Container(
                  // child: bezat > 0
                  //     ? nowShowingHorizontalListView(bezat)
                  //     : Padding(
                  //         padding: const EdgeInsets.only(top: 8.0),
                  //         child: Text(
                  //           "No Cinema Showing this Movie",
                  //           textAlign: TextAlign.center,
                  //           style: TextStyle(fontSize: 20),
                  //         ),
                  //       ),
                  // height: 250,

                  child: BlocBuilder<ScheduleBloc, ScheduleState>(
                    builder: (context, schedulestate) {
                      if (schedulestate is ScheduleOperationFailure) {
                        return Center(
                            child: Text(
                          'Could not do Schedule operation',
                          style: TextStyle(color: Colors.redAccent),
                        ));
                      }
                      if (schedulestate is ScheduleLoadSuccess) {
                        final schedules = schedulestate.schedules;
                        return nowShowingHorizontalListView(
                            schedules, widget.movie);
                      }

                      // if (schedulestate is ScheduleLoadByCinemaSuccess) {
                      //   final schedules = schedulestate.schedules;
                      //   return nowShowingHorizontalListView(schedules, movie);
                      // }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget nowShowingHorizontalListView(List<Schedule> nowShowing, Movie movie) {
    List<Cinema> cinemaFromID;
    List<Schedule> filteredSchedule = new List<Schedule>();
    List<int> filteredScheduleCinemaID = new List<int>();
    Cinema nowShowingCinema;

    nowShowing =
        nowShowing.where((schedule) => schedule.movieid == movie.id).toList();

    if (nowShowing.length == 0) {
      return SizedBox(
          height: 150,
          child: Center(child: Text("No Cinema Showing this Movie")));
    }
    for (var item in nowShowing) {
      if (filteredScheduleCinemaID.contains(item.cinemaid)) continue;

      filteredSchedule.add(item);
      filteredScheduleCinemaID.add(item.cinemaid);
    }
    return Container(
      height: 300,
      child: GridView.builder(
          //scrollDirection: Axis.horizontal,
          itemCount: filteredSchedule.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) {
            ScheduleEvent getSingleCinemaEvent =
                SinleCinemaFetchEvent(filteredSchedule[index]);
            BlocProvider.of<ScheduleBloc>(context).add(getSingleCinemaEvent);

            return Container(
              child: Card(
                elevation: 5,
                child: Hero(
                  tag: Text("Cinema "),
                  child: Material(
                    child: InkWell(
                      onTap: () => Navigator.of(context).popAndPushNamed(
                          UserCinemaSchedule.routeName,
                          arguments: nowShowingCinema),
                      child: GridTile(
                        child: Icon(
                          Icons.location_city,
                          size: 80,
                          color: const Color(0xff13c7ff),
                        ),
                        footer: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: BlocBuilder<CinemaBloc, CinemaState>(
                            builder: (context, cinemastate) {
                              if (cinemastate is CinemaLoadSuccess) {
                                cinemaFromID = cinemastate.cinemas;
                                nowShowingCinema = getNowShowingCinema(
                                    cinemaFromID, filteredSchedule, index);
                              }
                              return Center(
                                child: Text(nowShowingCinema == null
                                    ? ""
                                    : nowShowingCinema.name),
                              );
                            },
                          ),
                          // Text(
                          //               "Cinema ${++index}",
                          //               textAlign: TextAlign.center,
                          //               style: TextStyle(fontWeight: FontWeight.bold),
                          //             );
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  Cinema getNowShowingCinema(
      List<Cinema> cinms, List<Schedule> schdls, int index) {
    for (var item in cinms) {
      if (item.id == schdls[index].cinemaid) {
        return item;
      }
    }
    return null;
  }
}
