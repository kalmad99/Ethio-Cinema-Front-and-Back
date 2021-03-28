import 'bloc.dart';
import 'package:ethio_cinema_frontend/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ethio_cinema_frontend/bloc/bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationBloc _authenticationBloc;
  final AuthenticationRepository _authenticationRepository;

  LoginBloc(AuthenticationBloc authenticationBloc,
      AuthenticationRepository authentication_authenticationRepository)
      : assert(authenticationBloc != null),
        assert(authentication_authenticationRepository != null),
        _authenticationBloc = authenticationBloc,
        _authenticationRepository = authentication_authenticationRepository,
        super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginInWithEmailButtonPressed) {
      yield* _mapLoginWithEmailToState(event);
    }
  }

  Stream<LoginState> _mapLoginWithEmailToState(
      LoginInWithEmailButtonPressed event) async* {
    yield LoginLoading();
    try {
      final user = await _authenticationRepository
          .signInWithEmailAndPassword(event.user);
          print('user');
          
      if (user != null) {
        print('userEmail');
        print(user.email);
        _authenticationBloc.add(UserLoggedIn(user: user));
        yield LoginSuccess();
        yield LoginInitial();
      } else {
        yield LoginFailure(error: 'Something went wrong');
      }
    } on Exception catch (e) {
      print(e);
      yield LoginFailure(error: "");
    } catch (err) {
      yield LoginFailure(error: Error.safeToString(err) ?? 'An unknown error occured');
    }
  }
}
