import 'package:meta/meta.dart';

import 'package:ethio_cinema_frontend/dataprovider/data_provider.dart';
import 'package:ethio_cinema_frontend/models/model.dart';

class ScheduleRepository {
  final ScheduleDataProvider scheduleDataProvider;

  ScheduleRepository({@required this.scheduleDataProvider})
      : assert(scheduleDataProvider != null);

  Future<Schedule> createSchedule(Schedule schedule) async {
    return await scheduleDataProvider.createSchedule(schedule);
  }

  Future<List<Schedule>> getSchedules() async {
    return await scheduleDataProvider.getSchedules();
  }

  Future<List<Schedule>> getSchedulesByCinema(int id) async {
    return await scheduleDataProvider.getSchedulesByCinema(id);
  }

  // Future<List<Schedule>> getSchedulesByCinemaAndDay(int id, String day) async {
  //   return await scheduleDataProvider.getSchedulesByCinemaAndDate(id, day);
  // }

  Future<void> updateSchedule(Schedule schedule) async {
    await scheduleDataProvider.updateSchedule(schedule);
  }

  Future<void> deleteSchedule(int id) async {
    await scheduleDataProvider.deleteSchedule(id);
  }
}
