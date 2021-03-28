  
import 'package:ethio_cinema_frontend/dataprovider/data_provider.dart';
import 'package:ethio_cinema_frontend/models/model.dart';
import 'package:flutter/material.dart';

class UserRepository{

  final UserDataProvider dataProvider;
  UserRepository({@required this.dataProvider})
      : assert(dataProvider != null);


  Future<void> createUser(User user) async {
    await dataProvider.createUser(user);
  }

  
  Future<void> updateUser(User comment) async {  
    await dataProvider.updateUser(comment);
  }

  Future<void> deleteUser(int id) async {
    await dataProvider.deleteUser(id);
  }
}