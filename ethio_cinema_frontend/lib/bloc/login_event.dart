import 'package:ethio_cinema_frontend/models/model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInWithEmailButtonPressed extends LoginEvent {
  final User user;

  LoginInWithEmailButtonPressed({@required this.user});

  @override
  List<Object> get props => [user];
}
