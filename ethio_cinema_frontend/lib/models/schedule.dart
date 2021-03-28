import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Schedule extends Equatable{
  Schedule({
    this.id, 
    @required this.movieid, 
    @required this.starttime, 
    @required this.dimension, 
    @required this.cinemaid, 
    @required this.day,
    @required this.booked
  });

  final int id;
  final int movieid;
  final String starttime;
  final String dimension;
  final int cinemaid;
  final String day;
  final int booked;

  @override
  List<Object> get props => [id, movieid, starttime, dimension, cinemaid, day, booked];
  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'],
      movieid: json['movieid'],
      starttime: json['startingtime'],
      dimension: json['dimension'],
      cinemaid: json['cinemaid'],
      day: json['day'],
      booked: json['booked'],
    );
  }

  @override
  String toString() => 'Schedule { id: $id, movieid: $movieid, startingtime: $starttime, '
      'dimension: $dimension: cinemaid: $cinemaid, day: $day: booked: $booked}';

}