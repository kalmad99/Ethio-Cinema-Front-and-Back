import 'package:equatable/equatable.dart';

import 'package:ethio_cinema_frontend/models/model.dart';

class CinemaState extends Equatable {
  const CinemaState();

  @override
  List<Object> get props => [];
}

class CinemaLoading extends CinemaState {}

class CinemaLoadSuccess extends CinemaState {
  final List<Cinema> cinemas;
  CinemaLoadSuccess([this.cinemas = const []]);
  List<Object> get props => [cinemas];
}

class CinemaFetchedSingleState extends CinemaState {
  final Cinema cinema;

  CinemaFetchedSingleState([this.cinema]);

  @override
  List<Object> get props => [cinema];
}

class CinemaOpFailure extends CinemaState {
  CinemaOpFailure();
}
