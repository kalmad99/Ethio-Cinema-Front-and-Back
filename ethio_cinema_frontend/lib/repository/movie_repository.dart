import 'package:meta/meta.dart';

import 'package:ethio_cinema_frontend/dataprovider/data_provider.dart';
import 'package:ethio_cinema_frontend/models/model.dart';

class MovieRepository {
  final MovieDataProvider dataProvider;

  MovieRepository({@required this.dataProvider}) : assert(dataProvider != null);

  // Future<MovieID> createMovie(MovieID movie) async {
  //   return await dataProvider.createMovie(movie);
  // }

  Future<Movie> createMovie(Movie movie) async {
    return await dataProvider.createMovie(movie);
  }

  Future<List<Movie>> getMovies() async {
    return await dataProvider.getMovies();
  }

  Future<List<Movie>> searchMovies(String keyword) async {
    return await dataProvider.searchMovies(keyword);
  }

  Future<Movie> getSingleMovie(int id) async {
    return await dataProvider.getSingleMovie(id);
  }

  // Future<List<MovieID>> getMoviesID() async {
  //   return await dataProvider.getMoviesID();
  // }

  Future<void> updateMovie(Movie movie) async {
    await dataProvider.updateMovie(movie);
  }

  Future<void> deleteMovie(int id) async {
    await dataProvider.deleteMovie(id);
  }
}
