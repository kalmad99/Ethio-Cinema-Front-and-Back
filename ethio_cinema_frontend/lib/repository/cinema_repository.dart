import 'package:meta/meta.dart';

import 'package:ethio_cinema_frontend/dataprovider/data_provider.dart';
import 'package:ethio_cinema_frontend/models/model.dart';

class CinemaRepository {
  final CinemaDataProvider cinemaDataProvider;

  CinemaRepository({@required this.cinemaDataProvider})
      : assert(cinemaDataProvider != null);

  Future<Cinema> createCinema(Cinema cinema) async {
    return await cinemaDataProvider.createCinema(cinema);
  }

  Future<List<Cinema>> getCinemas() async {
    return await cinemaDataProvider.getCinemas();
  }

  Future<Cinema> getSingleCinema(int id) async {
    return await cinemaDataProvider.getSingleCinema(id);
  }

  Future<void> updateCinema(Cinema cinema) async {
    await cinemaDataProvider.updateCinema(cinema);
  }

  Future<void> deleteCinema(int id) async {
    await cinemaDataProvider.deleteCinema(id);
  }
}
