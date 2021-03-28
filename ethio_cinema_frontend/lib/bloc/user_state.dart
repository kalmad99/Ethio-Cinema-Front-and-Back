import 'package:ethio_cinema_frontend/models/model.dart';
import 'package:equatable/equatable.dart';

class UserState extends Equatable {
  UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserSuccessfull extends UserState {
  final User user;

  UserSuccessfull([this.user]);
  @override
  List<Object> get props => [user];
}

class UserInProgress extends UserState {}

class UserFailure extends UserState {}
