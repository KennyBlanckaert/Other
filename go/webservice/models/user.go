package models

// Imports
import (
	"reflect"
)

// User Object
// MUST be capitalized for the JSON decoder
type User struct {
	ID        int    `json:"id"`
	Firstname string `json:"firstname"`
	Lastname  string `json:"lastname"`
}

// Variables
var (
	users  = []*User{}
	nextID = 1
)

// GetUsers - return: Array of pointer (type User)
func GetUsers() []*User {
	return users
}

// GetUserByID - return: pointer (type User)
func GetUserByID(id int) *User {
	for _, user := range users {
		if user.ID == id {
			return user
		}
	}

	return nil
}

// AddUser - return: pointer (type User)
func AddUser(user User) (User, error) {
	user.ID = nextID
	nextID++

	users = append(users, &user)

	return user, nil
}

// RemoveUser - return: nil
func RemoveUser(user User) (User, error) {
	index := GetUserIndex(&user)
	last := len(users) - 1

	*users[index] = *users[last]
	users = users[:last]

	return user, nil
}

// GetUserIndex - return: index as integer
func GetUserIndex(user *User) int {
	for i := 0; i < len(users); i++ {
		if reflect.DeepEqual(user, *(users[i])) {
			return i
		}
	}

	return -1
}
