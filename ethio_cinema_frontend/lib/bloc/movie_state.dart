import 'package:equatable/equatable.dart';

import 'package:ethio_cinema_frontend/models/model.dart';

class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieLoading extends MovieState {}

class MovieLoadSuccess extends MovieState {
  final List<Movie> movies;

  MovieLoadSuccess([this.movies = const []]);

  @override
  List<Object> get props => [movies];
}

class MovieFetchedSingleState extends MovieState {
  final Movie movie;

  MovieFetchedSingleState([this.movie]);

  @override
  List<Object> get props => [movie];
}

class MovieOperationFailure extends MovieState {
  MovieOperationFailure();
}
