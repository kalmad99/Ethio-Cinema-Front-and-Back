import 'package:equatable/equatable.dart';

import 'package:ethio_cinema_frontend/models/model.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();
}

class MovieLoad extends MovieEvent {
  const MovieLoad();

  @override
  List<Object> get props => [];
}

class FetchSingleMovie extends MovieEvent {
  final int id;
  const FetchSingleMovie({this.id});

  @override
  List<Object> get props => [id];
}

class MovieSearch extends MovieEvent {
  final String keyword;
  const MovieSearch(this.keyword);

  @override
  List<Object> get props => [keyword];
}

class MovieCreate extends MovieEvent {
  final Movie movie;

  const MovieCreate(this.movie);

  @override
  List<Object> get props => [movie];

  @override
  String toString() => 'Movie Created {movie: $movie}';
}

class MovieUpdate extends MovieEvent {
  final Movie movie;

  const MovieUpdate(this.movie);

  @override
  List<Object> get props => [movie];

  @override
  String toString() => 'Movie Updated {movie: $movie}';
}

class MovieDelete extends MovieEvent {
  final Movie movie;

  const MovieDelete(this.movie);

  @override
  List<Object> get props => [movie];

  @override
  toString() => 'Movie Deleted {movie: $movie}';
}
