import 'package:equatable/equatable.dart';

import 'package:ethio_cinema_frontend/models/model.dart';

class ScheduleState extends Equatable {
  const ScheduleState();

  @override
  List<Object> get props => [];
}

class ScheduleLoading extends ScheduleState {}

class ScheduleLoadSuccess extends ScheduleState {
  final List<Schedule> schedules;

  ScheduleLoadSuccess([this.schedules = const []]);

  @override
  List<Object> get props => [schedules];
}

class ScheduleLoadByCinemaSuccess extends ScheduleState {
  final List<Schedule> schedules;

  ScheduleLoadByCinemaSuccess([this.schedules = const []]);

  @override
  List<Object> get props => [schedules];
}

class ScheduleLoadByCinemaAndDaySuccess extends ScheduleState {
  final List<Schedule> schedules;

  ScheduleLoadByCinemaAndDaySuccess([this.schedules = const []]);

  @override
  List<Object> get props => [schedules];
}

class ScheduleOperationFailure extends ScheduleState {
  ScheduleOperationFailure();
}
