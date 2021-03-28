import "package:flutter_bloc/flutter_bloc.dart";
import 'package:ethio_cinema_frontend/repository/repository.dart';
import 'package:ethio_cinema_frontend/bloc/bloc.dart';
import 'package:meta/meta.dart';

class CinemaBloc extends Bloc<CinemaEvent, CinemaState> {
  final CinemaRepository cinemarepo;

  CinemaBloc({@required this.cinemarepo})
      : assert(cinemarepo != null),
        super(CinemaLoading());

  @override
  Stream<CinemaState> mapEventToState(CinemaEvent event) async* {
    if (event is FetchSingleCinema) {
      try {
        final movie = await cinemarepo.getSingleCinema(event.id);
        yield CinemaFetchedSingleState(movie);
      } catch (e) {
        print(e);
        yield CinemaOpFailure();
      }
    }

    if (event is CinemaLoad) {
      yield CinemaLoading();
      try {
        print("IN BLOC");
        final cinemas = await cinemarepo.getCinemas();
        print("Worked");
        yield CinemaLoadSuccess(cinemas);
      } catch (e) {
        print(e);
        print("failed");
        yield CinemaOpFailure();
      }
    }

    if (event is CinemaCreate) {
      try {
        await cinemarepo.createCinema(event.cinema);
        final cinemas = await cinemarepo.getCinemas();
        yield CinemaLoadSuccess(cinemas);
      } catch (e) {
        print(e);
        yield CinemaOpFailure();
      }
    }

    if (event is CinemaUpdate) {
      try {
        await cinemarepo.updateCinema(event.cinema);
        final cinemas = await cinemarepo.getCinemas();
        yield CinemaLoadSuccess(cinemas);
      } catch (e) {
        print(e);
        yield CinemaOpFailure();
      }
    }

    if (event is CinemaDelete) {
      try {
        await cinemarepo.deleteCinema(event.cinema.id);
        final cinemas = await cinemarepo.getCinemas();
        yield CinemaLoadSuccess(cinemas);
      } catch (e) {
        print(e);
        yield CinemaOpFailure();
      }
    }
  }
}
