package schedule

import "github.com/kalmad99/bloctrial/model"

type ScheduleService interface {
	Schedules() ([]model.Schedule, []error)
	StoreSchedule(schedule *model.Schedule) (*model.Schedule, []error)
	CinemaSchedules(id uint, day string) ([]model.Schedule, []error)
	CinemaSchedulesbyCinema(id uint) ([]model.Schedule, []error)
	Schedule(id uint) (*model.Schedule, []error)
	UpdateSchedules(hall *model.Schedule) (*model.Schedule, []error)
	UpdateSchedulesBooked(user *model.Schedule, Amount uint) *model.Schedule
	DeleteSchedules(id uint) (*model.Schedule, []error)
	//ScheduleExists(cinemaid uint, movieid uint) bool
	ScheduleExists(cinemaid uint, movieid uint, date string, startingTime string) bool
}