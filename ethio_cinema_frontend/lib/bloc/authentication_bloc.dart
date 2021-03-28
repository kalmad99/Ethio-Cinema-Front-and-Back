import 'bloc.dart';
import 'package:ethio_cinema_frontend/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository authenticationRepository;

  AuthenticationBloc({@required this.authenticationRepository})
      : assert(authenticationRepository != null),
        super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppLoaded) {
      yield* _mapAppLoadedToState(event);
    }

    if (event is UserLoggedIn) {
      yield* _mapUserLoggedInToState(event);
    }

    if (event is UserLoggedOut) {
      yield* _mapUserLoggedOutToState(event);
    }
  }

  Stream<AuthenticationState> _mapAppLoadedToState(AppLoaded event) async* {
    print('User about to Login');
    yield AuthenticationLoading();
    try {
      await Future.delayed(Duration(milliseconds: 500));
      final currentUser = await authenticationRepository.getCurrentUser();

      if (currentUser != null) {
        yield AuthenticationAuthenticated(user: currentUser);
      } else {
        yield AuthenticationNotAuthenticated();
      }
    } catch (e) {
      yield AuthenticationFailure(
          message: Error.safeToString(e) ?? 'An unknown error occurred');
    }
  }

  Stream<AuthenticationState> _mapUserLoggedInToState(
      UserLoggedIn event) async* {
    print("User Successfully Logged in");
    yield AuthenticationAuthenticated(user: event.user);
  }

  Stream<AuthenticationState> _mapUserLoggedOutToState(
      UserLoggedOut event) async* {
    print("User Successfully Logged out");
    await authenticationRepository.signOut();
    yield AuthenticationNotAuthenticated();
  }
}
