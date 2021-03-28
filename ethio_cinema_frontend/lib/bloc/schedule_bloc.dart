import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ethio_cinema_frontend/repository/repository.dart';
import 'bloc.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final ScheduleRepository scheduleRepository;

  ScheduleBloc({@required this.scheduleRepository})
      : assert(scheduleRepository != null),
        super(ScheduleLoading());

  @override
  Stream<ScheduleState> mapEventToState(ScheduleEvent event) async* {
    if (event is ScheduleLoad) {
      yield ScheduleLoading();
      try {
        print("IN BLOC");
        // final schedules = await scheduleRepository
        //     .getSchedulesByCinema(event.schedule.cinemaid);

        final schedules = await scheduleRepository.getSchedules();
        print("Worked");
        yield ScheduleLoadSuccess(schedules);
      } catch (e) {
        print(e);
        print("failed");
        yield ScheduleOperationFailure();
      }
    }

    if (event is ScheduleLoadByCinemaID) {
      yield ScheduleLoading();
      try {
        print("IN BLOC");
        // final schedules = await scheduleRepository
        //     .getSchedulesByCinema(event.schedule.cinemaid);

        final schedules =
            await scheduleRepository.getSchedulesByCinema(event.id);
        print("Worked");
        yield ScheduleLoadByCinemaSuccess(schedules);
      } catch (e) {
        print(e);
        print("failed");
        yield ScheduleOperationFailure();
      }
    }

    // if (event is ScheduleLoadByCinemaIDAndDay) {
    //   yield ScheduleLoading();
    //   try {
    //     print("IN BLOC");
    //     // final schedules = await scheduleRepository
    //     //     .getSchedulesByCinema(event.schedule.cinemaid);

    //     final schedules = await scheduleRepository.getSchedulesByCinemaAndDay(
    //         event.id, event.day);
    //     print("Worked");
    //     yield ScheduleLoadByCinemaAndDaySuccess(schedules);
    //   } catch (e) {
    //     print(e);
    //     print("failed");
    //     yield ScheduleOperationFailure();
    //   }
    // }

    // var mock = Schedule(title: "The Commuter", overview: "A thrilling schedule", image: "commuter.jpg",
    // rating: 6.1, release_date: "September 21/2019");
    if (event is ScheduleCreate) {
      try {
        // await scheduleRepository.createSchedule(mock);
        await scheduleRepository.createSchedule(event.schedule);
        // final schedules = await scheduleRepository
        //     .getSchedulesByCinema(event.schedule.cinemaid);

        final schedules = await scheduleRepository.getSchedules();
        yield ScheduleLoadSuccess(schedules);
      } catch (e) {
        print(e);
        yield ScheduleOperationFailure();
      }
    }

    if (event is ScheduleUpdate) {
      try {
        await scheduleRepository.updateSchedule(event.schedule);
        // final schedules = await scheduleRepository
        //     .getSchedulesByCinema(event.schedule.cinemaid);

        final schedules = await scheduleRepository.getSchedules();
        yield ScheduleLoadSuccess(schedules);
      } catch (e) {
        print(e);

        yield ScheduleOperationFailure();
      }
    }

    if (event is ScheduleDelete) {
      try {
        await scheduleRepository.deleteSchedule(event.schedule.id);
        // final schedules = await scheduleRepository
        //     .getSchedulesByCinema(event.schedule.cinemaid);

        final schedules = await scheduleRepository
            .getSchedulesByCinema(event.schedule.cinemaid);
        yield ScheduleLoadByCinemaSuccess(schedules);
      } catch (e) {
        print(e);
        yield ScheduleOperationFailure();
      }
    }
  }
}
