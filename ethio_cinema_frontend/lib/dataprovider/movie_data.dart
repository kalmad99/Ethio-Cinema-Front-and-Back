import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:ethio_cinema_frontend/shared_preferences.dart';
import 'package:ethio_cinema_frontend/constants.dart';
import 'package:ethio_cinema_frontend/models/model.dart';

class MovieDataProvider {
  // final baseURL = 'http://3e41c9338e5b.ngrok.io';
  // final baseURL = 'a4e96256f78d.ngrok.io';
  final http.Client httpClient;

  MovieDataProvider({@required this.httpClient}) : assert(httpClient != null);

  Future<Movie> createMovie(Movie movie) async {
    final response = await httpClient.post(
      Uri.http("$socketAddress:8181", '/admin/movies'),
      headers: await SharedPrefUtils.getStringValuesSF().then((token) {
        print(token);
        return (<String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        });
      }),
      body: jsonEncode(<String, dynamic>{
        'title': movie.title,
        'poster_path': movie.image,
        'overview': movie.overview,
        'release_date': movie.release_date,
        'rating': movie.rating,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Create worked");
      return Movie.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create movie.');
    }
  }

  Future<List<Movie>> getMovies() async {
    final response = await httpClient.get('$baseURL/api/movies',
        headers: await SharedPrefUtils.getStringValuesSF().then((token) {
          print(token);
          return (<String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          });
        }));

    if (response.statusCode == 200) {
      final movies = jsonDecode(response.body) as List;
      var moviesmapped = movies.map((movie) => Movie.fromJson(movie)).toList();

      return moviesmapped;
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<Movie> getSingleMovie(int id) async {
    final response = await httpClient.get('$baseURL/api/movies/$id',
        headers: await SharedPrefUtils.getStringValuesSF().then((token) {
          print(token);
          return (<String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          });
        }));

    if (response.statusCode == 200 || response.statusCode == 201) {
      final movies = jsonDecode(response.body);
      var moviesmapped = movies.map((movie) => Movie.fromJson(movie));

      return moviesmapped;
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List<Movie>> searchMovies(String query) async {
    final response = await httpClient.get('$baseURL/api/search?query=$query',
        headers: await SharedPrefUtils.getStringValuesSF().then((token) {
          print(token);
          return (<String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          });
        }));

    if (response.statusCode == 200) {
      final movies = jsonDecode(response.body) as List;
      var moviesmapped = movies.map((movie) => Movie.fromJson(movie)).toList();

      return moviesmapped;
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<void> deleteMovie(int id) async {
    final http.Response response = await httpClient.delete(
      '$baseURL/admin/movies/$id',
      headers: await SharedPrefUtils.getStringValuesSF().then((token) {
        print(token);
        return (<String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        });
      }),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete movies.');
    }
  }

  Future<void> updateMovie(Movie movie) async {
    final http.Response response = await httpClient.put(
      '$baseURL/admin/movies/${movie.id}',
      headers: await SharedPrefUtils.getStringValuesSF().then((token) {
        print(token);
        return (<String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        });
      }),
      body: jsonEncode(<String, dynamic>{
        'id': movie.id,
        'title': movie.title,
        'poster_path': movie.image,
        'overview': movie.overview,
        'release_date': movie.release_date,
        'rating': movie.rating,
      }),
    );

    if (response.statusCode != 200) {
      print(response.statusCode);
      throw Exception('Failed to update movies.');
    }
  }
}
