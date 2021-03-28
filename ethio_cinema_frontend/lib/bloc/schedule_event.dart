import 'package:equatable/equatable.dart';

import 'package:ethio_cinema_frontend/models/model.dart';

abstract class ScheduleEvent extends Equatable {
  const ScheduleEvent();
}

class ScheduleLoad extends ScheduleEvent {
  const ScheduleLoad();

  @override
  List<Object> get props => [];
}

class ScheduleCreate extends ScheduleEvent {
  final Schedule schedule;

  const ScheduleCreate(this.schedule);

  @override
  List<Object> get props => [schedule];

  @override
  String toString() => 'Schedule Created {schedule: $schedule}';
}

class ScheduleUpdate extends ScheduleEvent {
  final Schedule schedule;

  const ScheduleUpdate(this.schedule);

  @override
  List<Object> get props => [schedule];

  @override
  String toString() => 'Schedule Updated {schedule: $schedule}';
}

class ScheduleDelete extends ScheduleEvent {
  final Schedule schedule;

  const ScheduleDelete(this.schedule);

  @override
  List<Object> get props => [schedule];

  @override
  toString() => 'Schedule Deleted {schedule: $schedule}';
}

class SinleMovieFetchEvent extends ScheduleEvent {
  final Schedule schedule;

  const SinleMovieFetchEvent(this.schedule);

  @override
  List<Object> get props => [schedule];

  @override
  toString() => 'Schedule Fetched {schedule: $schedule}';
}

class SinleCinemaFetchEvent extends ScheduleEvent {
  final Schedule schedule;

  const SinleCinemaFetchEvent(this.schedule);

  @override
  List<Object> get props => [schedule];

  @override
  toString() => 'Schedule Fetched {schedule: $schedule}';
}

class ScheduleLoadByCinemaID extends ScheduleEvent {
  final int id;

  const ScheduleLoadByCinemaID(this.id);

  @override
  List<Object> get props => [id];

  @override
  toString() => 'Schedule Loaded {schedule: $id}';
}

class ScheduleLoadByCinemaIDAndDay extends ScheduleEvent {
  final int id;
  final String day;

  const ScheduleLoadByCinemaIDAndDay(this.id, this.day);

  @override
  List<Object> get props => [id, day];

  @override
  toString() => 'Schedule Loaded {schedule: $id}';
}
