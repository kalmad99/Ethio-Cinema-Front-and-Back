import 'bloc_observer.dart';
import 'sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'bloc/bloc.dart';
import 'dataprovider/data_provider.dart';
import 'pages/screen.dart';
import 'repository/repository.dart';

void main() {
  final AuthenticationRepository authenticationRepository =
      AuthenticationRepository(
    dataProvider: AuthenticationDataProvider(
      httpClient: http.Client(),
    ),
  );

  final UserRepository userRepository = UserRepository(
    dataProvider: UserDataProvider(
      httpClient: http.Client(),
    ),
  );

  final CinemaRepository cinemaRepository = CinemaRepository(
    cinemaDataProvider: CinemaDataProvider(
      httpClient: http.Client(),
    ),
  );

  final MovieRepository movieRepository = MovieRepository(
    dataProvider: MovieDataProvider(
      httpClient: http.Client(),
    ),
  );

  final ScheduleRepository scheduleRepository = ScheduleRepository(
    scheduleDataProvider: ScheduleDataProvider(
      httpClient: http.Client(),
    ),
  );

  Bloc.observer = SimpleBlocObserver();
  runApp(
    EthioCinemaApp(
      cinemaRepository: cinemaRepository,
      movieRepository: movieRepository,
      scheduleRepository: scheduleRepository,
      userRepository: userRepository,
      authenticationRepository: authenticationRepository,
    ),
  );
}

class EthioCinemaApp extends StatelessWidget {
  final CinemaRepository cinemaRepository;
  final MovieRepository movieRepository;
  final ScheduleRepository scheduleRepository;
  final UserRepository userRepository;
  final AuthenticationRepository authenticationRepository;

  EthioCinemaApp({
    @required this.cinemaRepository,
    @required this.movieRepository,
    @required this.scheduleRepository,
    @required this.userRepository,
    @required this.authenticationRepository,
  }) : assert(cinemaRepository != null ||
            movieRepository != null ||
            scheduleRepository != null ||
            userRepository != null ||
            authenticationRepository != null);
//

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => this.cinemaRepository),
        RepositoryProvider(create: (context) => this.movieRepository),
        RepositoryProvider(create: (context) => this.scheduleRepository),
        RepositoryProvider(create: (context) => this.userRepository),
        RepositoryProvider(create: (context) => this.authenticationRepository),
      ],
      //value: this.recipeRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => AuthenticationBloc(
                  authenticationRepository: this.authenticationRepository)),
          BlocProvider(
              create: (context) => UserBloc(
                  authenticationBloc: AuthenticationBloc(
                      authenticationRepository: authenticationRepository),
                  authenticationRepository: authenticationRepository,
                  userRepository: this.userRepository)),
          BlocProvider(
              lazy: false,
              create: (context) => CinemaBloc(cinemarepo: this.cinemaRepository)
                ..add(CinemaLoad())),
          BlocProvider(
              lazy: false,
              create: (context) =>
                  MovieBloc(movieRepository: this.movieRepository)
                    ..add(MovieLoad())),
          BlocProvider(
              lazy: false,
              create: (context) =>
                  ScheduleBloc(scheduleRepository: this.scheduleRepository)
                    ..add(ScheduleLoad())),

        ],
        // create: (context) => RecipeBloc(recipeRepository: this.recipeRepository)..add(RecipeRetrieve()),
        child: MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: ThemeData.light().textTheme.copyWith(),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (_, state) {
            if (state is AuthenticationAuthenticated) {
              final user = state.user;
              if (user.roleID == 2) {
                return AdminMainPage();
              }
              return UserMainPage();
            } else {
              print(state);
              return AuthForm();
            }
          }),
          onGenerateRoute: EthioCinemaAppRoute.generateRoute,
        ),
      ),
    );
  }
}
