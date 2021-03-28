import 'dart:convert';

import 'package:ethio_cinema_frontend/constants.dart';
import 'package:ethio_cinema_frontend/models/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:ethio_cinema_frontend/shared_preferences.dart';

class AuthenticationDataProvider {
  final http.Client httpClient;

  AuthenticationDataProvider({@required this.httpClient})
      : assert(httpClient != null);

  Future<User> signInWithEmailAndPassword(User user) async {
    final response = await httpClient.post(
      Uri.http('$socketAddress:8181', '/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, dynamic>{'pass': user.password, 'email': user.email}),
    );
    print(user.password);
    print(user.email);

    final jwt = jsonDecode(response.body);
    final token = jwt['token'];
    print("token: $token");
    SharedPrefUtils.addStringToSF(token);
    Map<String, dynamic> payload = Jwt.parseJwt(token);

    print(payload);

    if (response.statusCode == 200) {
      return User(
          email: payload['User']['email'].toString(),
          password: payload['User']['pass'].toString(),
          roleID: payload['User']['RoleID'],
          fullname: payload['User']['name'].toString());
    } else {
      throw Exception('Failed to retrieve user.');
    }
  }

  Future<bool> logOut() async {
    SharedPrefUtils.destroyStringValuesSF();
    return true;
  }
}
