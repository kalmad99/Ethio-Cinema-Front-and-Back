import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:ethio_cinema_frontend/shared_preferences.dart';
import 'package:ethio_cinema_frontend/constants.dart';
import 'package:ethio_cinema_frontend/models/model.dart';

class CinemaDataProvider {
  // final _baseUrl = 'http://192.168.8.101:8181';
  final http.Client httpClient;

  CinemaDataProvider({@required this.httpClient}) : assert(httpClient != null);

  Future<Cinema> createCinema(Cinema cinema) async {
    final response = await httpClient.post(
      Uri.http('$socketAddress:8181', '/admin/cinemas'),
      headers: await SharedPrefUtils.getStringValuesSF().then((token) {
        print(token);
        return (<String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        });
      }),
      body: jsonEncode(<String, dynamic>{
        'name': cinema.name,
        'price': cinema.price,
        'vipprice': cinema.vipprice,
        'capacity': cinema.capacity,
        'vipcapacity': cinema.vipcapacity,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Create worked");
      return Cinema.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create movie.');
    }
  }

  Future<List<Cinema>> getCinemas() async {
    final http.Response response = await httpClient.get('$baseURL/api/cinemas',
        headers: await SharedPrefUtils.getStringValuesSF().then((token) {
          print(token);
          return (<String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          });
        }));
    if (response.statusCode == 200) {
      final cinemas = jsonDecode(response.body) as List;
      return cinemas.map((cinema) => Cinema.fromJson(cinema)).toList();
    } else {
      throw Exception('Failed to load cinemas');
    }
  }

  Future<Cinema> getSingleCinema(int id) async {
    final response = await httpClient.get('$baseURL/api/cinemas/$id',
        headers: await SharedPrefUtils.getStringValuesSF().then((token) {
          print(token);
          return (<String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          });
        }));

    if (response.statusCode == 200) {
      final cinema = jsonDecode(response.body);
      var moviesmapped = cinema.map((cinema) => Cinema.fromJson(cinema));

      return moviesmapped;
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<void> updateCinema(Cinema cinema) async {
    final http.Response response = await httpClient.put(
      '$baseURL/admin/cinemas/${cinema.id}',
      headers: await SharedPrefUtils.getStringValuesSF().then((token) {
        print(token);
        return (<String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        });
      }),
      body: jsonEncode(<String, dynamic>{
        'id': cinema.id,
        'name': cinema.name,
        'price': cinema.price,
        'vipprice': cinema.vipprice,
        'capacity': cinema.capacity,
        'vipcapacity': cinema.vipcapacity,
      }),
    );

    if (response.statusCode != 200) {
      print(response.statusCode);
      throw Exception('Failed to update movies.');
    }
  }

  Future<void> deleteCinema(int id) async {
    final http.Response response =
        await httpClient.delete('$baseURL/admin/cinemas/$id',
            headers: await SharedPrefUtils.getStringValuesSF().then((token) {
              print(token);
              return (<String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': 'Bearer $token',
              });
            }));

    if (response.statusCode != 204) {
      throw Exception('Cant delete Cinema');
    }
  }
}
