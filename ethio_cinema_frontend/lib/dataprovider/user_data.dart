import 'dart:convert';
import 'package:ethio_cinema_frontend/shared_preferences.dart';

import 'package:ethio_cinema_frontend/constants.dart';
import 'package:ethio_cinema_frontend/models/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserDataProvider {
  final http.Client httpClient;

  UserDataProvider({@required this.httpClient}) : assert(httpClient != null);

  Future<void> createUser(User user) async {
    final response = await httpClient.post(
      Uri.http('$socketAddress:8181', '/signup'),
      headers: (<String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }),
      body: jsonEncode(<String, dynamic>{
        'name': user.fullname,
        'pass': user.password,
        'email': user.email,
      }),
    );

    print(response.statusCode);
    if (response.statusCode != 200) {
      throw Exception('Failed to sign up');
    }
  }

  Future<void> deleteUser(int id) async {
    final response = await httpClient.delete(
      '$baseURL/user/$id',
      headers: await SharedPrefUtils.getStringValuesSF().then((token) {
        print(token);
        return (<String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        });
      }),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete user.');
    }
  }

  Future<void> updateUser(User user) async {
    final response = await httpClient.put(
      '$baseURL/user/${user.id}',
      headers: await SharedPrefUtils.getStringValuesSF().then((token) {
        print(token);
        return (<String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        });
      }),
      body: jsonEncode(<String, dynamic>{
        'id': user.id,
        'name': user.fullname,
        'pass': user.password,
        'email': user.email,
      }),
    );
    print('status code.${response.statusCode}');
    if (response.statusCode != 200) {
      throw Exception('Failed to update user.');
    }
  }
}
