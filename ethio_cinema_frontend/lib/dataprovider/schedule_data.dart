import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:ethio_cinema_frontend/shared_preferences.dart';
import 'package:ethio_cinema_frontend/constants.dart';
import 'package:ethio_cinema_frontend/models/model.dart';

class ScheduleDataProvider {
  final http.Client httpClient;

  ScheduleDataProvider({@required this.httpClient})
      : assert(httpClient != null);

  Future<Schedule> createSchedule(Schedule schedule) async {
    final response = await httpClient.post(
      Uri.http('$socketAddress:8181', '/admin/schedules'),
      headers: await SharedPrefUtils.getStringValuesSF().then((token) {
        print(token);
        return (<String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        });
      }),
      body: jsonEncode(<String, dynamic>{
        'movieid': schedule.movieid,
        'startingtime': schedule.starttime,
        'dimension': schedule.dimension,
        'cinemaid': schedule.cinemaid,
        'day': schedule.day,
        'booked': schedule.booked,
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      print("Create worked");
      return Schedule.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to make schedule.');
    }
  }

  Future<List<Schedule>> getSchedules() async {
    final http.Response response =
        await httpClient.get('$baseURL/api/schedules',
            headers: await SharedPrefUtils.getStringValuesSF().then((token) {
              print(token);
              return (<String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': 'Bearer $token',
              });
            }));

    if (response.statusCode == 200) {
      final schedules = jsonDecode(response.body) as List;
      return schedules.map((schedule) => Schedule.fromJson(schedule)).toList();
    } else {
      throw Exception('Failed to load schedules');
    }
  }

  Future<List<Schedule>> getSchedulesByCinema(int id) async {
    final http.Response response =
        await httpClient.get('$baseURL/api/schedules/$id',
            headers: await SharedPrefUtils.getStringValuesSF().then((token) {
              print(token);
              return (<String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': 'Bearer $token',
              });
            }));

    if (response.statusCode == 200) {
      final schedules = jsonDecode(response.body) as List;
      return schedules.map((schedule) => Schedule.fromJson(schedule)).toList();
    } else {
      throw Exception('Failed to load schedules');
    }
  }

  // Future<List<Schedule>> getSchedulesByCinemaAndDate(
  //     int id, String date) async {
  //   Map<String, String> queryParams = {'day': '$date'};
  //   String queryString = Uri(queryParameters: queryParams).query;
  //   final http.Response response =
  //       await httpClient.get('$baseURL/schedules/$id?$queryString');

  //   if (response.statusCode == 200) {
  //     final schedules = jsonDecode(response.body) as List;
  //     return schedules.map((schedule) => Schedule.fromJson(schedule)).toList();
  //   } else {
  //     throw Exception('Failed to load schedules');
  //   }
  // }

  Future<void> updateSchedule(Schedule schedule) async {
    final http.Response response = await httpClient.put(
      '$baseURL/admin/schedules/${schedule.id}',
      headers: await SharedPrefUtils.getStringValuesSF().then((token) {
        print(token);
        return (<String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        });
      }),
      body: jsonEncode(<String, dynamic>{
        'id': schedule.id,
        'movieid': schedule.movieid,
        'startingtime': schedule.starttime,
        'dimension': schedule.dimension,
        'cinemaid': schedule.cinemaid,
        'day': schedule.day,
        'booked': schedule.booked,
      }),
    );

    if (response.statusCode != 200) {
      print(response.statusCode);
      throw Exception('Failed to update schedule.');
    }
  }

  Future<void> deleteSchedule(int id) async {
    final http.Response response = await httpClient.delete(
      '$baseURL/admin/schedules/$id',
      headers: await SharedPrefUtils.getStringValuesSF().then((token) {
        print(token);
        return (<String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        });
      }),
    );

    if (response.statusCode != 204) {
      throw Exception('Cant delete Schedule');
    }
  }
}
