import 'package:flutter/material.dart';

class User {
  final int id;
  final String fullname;
  final String phone;
  final String email;
  final String password;
  final String profilePicture;
  final int amount;
  final int roleID;

  User({
    this.id,
    @required this.fullname,
    this.phone,
    @required this.email,
    @required this.password,
    this.profilePicture,
    this.amount,
    this.roleID,
  });

  User.login({
    this.id,
    this.fullname,
    this.phone,
    @required this.email,
    @required this.password,
    this.profilePicture,
    this.amount,
    this.roleID,
  });

  User.fromJSON(Map<String, dynamic> json)
  //yehenen new??yeah
      : id = json['id'] ?? '',
        fullname = json['name'] ?? '',
        phone = json['Phone'] ?? '',
        email = json['email'] ?? '',
        password = json['pass'] ?? '',
        profilePicture = json['ProfilePicture'] ?? '',
        roleID = json['RoleID'] ?? '',
        amount = json['amount'] ?? '';
}
