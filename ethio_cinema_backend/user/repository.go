package user

import (
	"github.com/kalmad99/bloctrial/model"
)

type UserRepository interface {
	User(id uint) (*model.User, []error)
	UserByEmail(email string) (*model.User, []error)
	UpdateUserAmount(user *model.User, Amount uint) *model.User
	//UpdateUserAmount(user *model.User, Amount uint) (*model.User, error)
	UpdateUser(user *model.User) (*model.User, []error)
	DeleteUser(id uint) (*model.User, []error)
	StoreUser(user *model.User) (*model.User, []error)
	EmailExists(email string) bool
}
type RoleRepository interface {
	Roles() ([]model.Role, []error)
	Role(id uint) (*model.Role, []error)
	RoleByName(name string) (*model.Role, []error)
	UpdateRole(role *model.Role) (*model.Role, []error)
	DeleteRole(id uint) (*model.Role, []error)
	StoreRole(role *model.Role) (*model.Role, []error)
}
