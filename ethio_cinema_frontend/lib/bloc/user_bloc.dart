import 'package:ethio_cinema_frontend/bloc/bloc.dart';
import 'package:ethio_cinema_frontend/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;
  final AuthenticationRepository authenticationRepository;

  UserBloc(
      {@required this.authenticationBloc,
      @required this.userRepository,
      @required this.authenticationRepository})
      : assert(authenticationBloc != null ||
            authenticationRepository != null ||
            authenticationRepository != null),
        super(UserInProgress());

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is UserCreate) {
      print('fired user create');
      try {
        await userRepository.createUser(event.user);
        yield UserSuccessfull();
        yield UserInitial();
      } catch (e) {
        print(e);
        yield UserFailure();
      }
    }

    if (event is UserDelete) {
      try {
        int id = event.user.id;
        await userRepository.deleteUser(id);
        authenticationBloc.add(UserLoggedOut());
        yield UserSuccessfull();
      } catch (_) {
        yield UserFailure();
      }
    }
    if (event is UserUpdate) {
      int id = event.user.id;
      print(id);
      try {
        await userRepository.updateUser(event.user);
        // final user = await authenticationRepository.getUser(id);
        authenticationBloc.add(UserLoggedIn(user: event.user));
        yield UserSuccessfull(event.user);
      } catch (_) {
        yield UserFailure();
      }
    }
  }
}
