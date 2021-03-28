import 'package:equatable/equatable.dart';

import 'package:ethio_cinema_frontend/models/model.dart';

abstract class CinemaEvent extends Equatable {
  const CinemaEvent();
}

class CinemaLoad extends CinemaEvent {
  const CinemaLoad();

  @override
  List<Object> get props => [];
}

class FetchSingleCinema extends CinemaEvent {
  final int id;
  const FetchSingleCinema({this.id});

  @override
  List<Object> get props => [id];
}

class CinemaCreate extends CinemaEvent {
  final Cinema cinema;

  const CinemaCreate(this.cinema);

  @override
  List<Object> get props => [cinema];

  @override
  String toString() => 'Cinema Created {Cinema: $cinema}';
}

class CinemaUpdate extends CinemaEvent {
  final Cinema cinema;

  const CinemaUpdate(this.cinema);

  @override
  List<Object> get props => [cinema];

  @override
  String toString() => 'Cinema Updated {Cinema: $cinema}';
}

class CinemaDelete extends CinemaEvent {
  final Cinema cinema;

  const CinemaDelete(this.cinema);

  @override
  List<Object> get props => [cinema];

  @override
  toString() => 'Cinema Deleted {Cinema: $cinema}';
}
