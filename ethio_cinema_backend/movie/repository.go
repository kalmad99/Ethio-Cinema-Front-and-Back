package movie

import "github.com/kalmad99/bloctrial/model"

type MovieRepository interface {
	Movies() ([]model.Movie, []error)
	Movie(id uint) (*model.Movie, []error)
	UpdateMovie(movie *model.Movie) (*model.Movie, []error)
	DeleteMovie(id uint) (*model.Movie, []error)
	StoreMovie(movie *model.Movie) (*model.Movie, []error)
	SearchMovie(index string) ([]model.Movie, error)
	MovieExists(movieName string) bool
}