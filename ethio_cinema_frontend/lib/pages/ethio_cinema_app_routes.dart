import 'package:ethio_cinema_frontend/pages/user/about_us_page.dart';

import 'package:ethio_cinema_frontend/pages/user/booking_page.dart';
import 'package:ethio_cinema_frontend/pages/user/user_cinema_schedule.dart';
import 'package:ethio_cinema_frontend/pages/user/user_main_page.dart';
import 'package:ethio_cinema_frontend/pages/user/user_movie_detail_page.dart';
import 'package:ethio_cinema_frontend/sign_in.dart';
import 'package:ethio_cinema_frontend/sign_up.dart';
import 'package:flutter/material.dart';

import 'package:ethio_cinema_frontend/models/model.dart';
import 'screen.dart';

class EthioCinemaAppRoute {
  static Route generateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) => SignInPage());
    }

    if (settings.name == CinemaDetail.routeName) {
      Cinema cinema = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => CinemaDetail(
                cinema: cinema,
              ));
    }

    if (settings.name == UserMainPage.routeName) {
      return MaterialPageRoute(builder: (context) => UserMainPage());
    }

    if (settings.name == AdminMainPage.routeName) {
      return MaterialPageRoute(builder: (context) => AdminMainPage());
    }

    if (settings.name == SignUpPage.routeName) {
      return MaterialPageRoute(builder: (context) => SignUpPage());
    }

    if (settings.name == BookingPage.routeName) {
      return MaterialPageRoute(builder: (context) => BookingPage());
    }

    if (settings.name == AboutUs.routeName) {
      return MaterialPageRoute(builder: (context) => AboutUs());
    }

    if (settings.name == AddCinema.routeName) {
      //Cinema cinema = settings.arguments;
      return MaterialPageRoute(builder: (context) => AddCinema());
    }

    if (settings.name == AddMovie.routeName) {
      //Cinema cinema = settings.arguments;
      return MaterialPageRoute(builder: (context) => AddMovie());
    }

    if (settings.name == MovieDetails.routeName) {
      Movie movie = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => MovieDetails(
                movie: movie,
              ));
    }

    if (settings.name == UserMovieDetail.routeName) {
      Movie movie = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => UserMovieDetail(
                movie: movie,
              ));
    }

    if (settings.name == EditMovie.routeName) {
      Movie movie = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => EditMovie(
                movie: movie,
              ));
    }

    if (settings.name == CinemaSchedule.routeName) {
      Cinema cinema = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => CinemaSchedule(
                cinema: cinema,
              ));
    }

    if (settings.name == UserCinemaSchedule.routeName) {
      Cinema cinema = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => UserCinemaSchedule(
                cinema: cinema,
              ));
    }

    if (settings.name == ScheduleAdd.routeName) {
      Cinema cinema = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => ScheduleAdd(
                cinema: cinema,
              ));
    }

    if (settings.name == ScheduleEdit.routeName) {
      ScheduleEditArguments arguments = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => ScheduleEdit(
                args: arguments,
              ));
    }
    //  return MaterialPageRoute(builder: (context) => SignInPage());
  }
}

class ScheduleEditArguments {
  final Cinema cinema;
  final Movie movie;
  final Schedule schedule;
  ScheduleEditArguments({this.cinema, this.movie, this.schedule});
}
