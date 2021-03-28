import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ethio_cinema_frontend/repository/repository.dart';
import 'package:ethio_cinema_frontend/bloc/bloc.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository;

  MovieBloc({@required this.movieRepository})
      : assert(movieRepository != null),
        super(MovieLoading());

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is FetchSingleMovie) {
      try {
        final movie = await movieRepository.getSingleMovie(event.id);
        yield MovieFetchedSingleState(movie);
      } catch (e) {
        print(e);
        yield MovieOperationFailure();
      }
    }

    if (event is MovieSearch) {
      yield MovieLoading();
      try {
        print("IN BLOC");
        final movies = await movieRepository.searchMovies(event.keyword);
        print("Worked");
        yield MovieLoadSuccess(movies);
      } catch (e) {
        print(e);
        print("failed");
        yield MovieOperationFailure();
      }
    }
    if (event is MovieLoad) {
      yield MovieLoading();
      try {
        print("IN BLOC");
        final movies = await movieRepository.getMovies();
        print("Worked");
        yield MovieLoadSuccess(movies);
      } catch (e) {
        print(e);
        print("failed");
        yield MovieOperationFailure();
      }
    }

    // var mock = Movie(title: "The Commuter", overview: "A thrilling movie", image: "commuter.jpg",
    // rating: 6.1, release_date: "September 21/2019");
    if (event is MovieCreate) {
      try {
        // await movieRepository.createMovie(mock);
        await movieRepository.createMovie(event.movie);
        final movies = await movieRepository.getMovies();
        yield MovieLoadSuccess(movies);
      } catch (e) {
        print(e);
        yield MovieOperationFailure();
      }
    }

    if (event is MovieUpdate) {
      try {
        await movieRepository.updateMovie(event.movie);
        final movies = await movieRepository.getMovies();
        yield MovieLoadSuccess(movies);
      } catch (e) {
        print(e);

        yield MovieOperationFailure();
      }
    }

    if (event is MovieDelete) {
      try {
        await movieRepository.deleteMovie(event.movie.id);
        final movies = await movieRepository.getMovies();
        yield MovieLoadSuccess(movies);
      } catch (e) {
        print(e);
        yield MovieOperationFailure();
      }
    }
  }
}
