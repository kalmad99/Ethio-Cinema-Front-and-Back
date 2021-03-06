package booking

import "github.com/kalmad99/bloctrial/model"

// CommentService specifies  Booking related service
type BookingRepository interface {
	Bookings(uid uint) ([]model.Booking, []error)
	StoreBooking(Booking *model.Booking) (*model.Booking, []error)
	GetSingleBooking(id uint) (*model.Booking, []error)
	UpdateBooking(Booking *model.Booking) (*model.Booking, []error)
	DeleteBooking(id uint) (*model.Booking, []error)
	BookingExists(userid uint, sched uint) bool
}



