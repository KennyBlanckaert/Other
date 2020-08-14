package models

import "errors"

// Imports

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
	users = append(users[:index], users[index:]...)
	users = users[:last]

	return user, nil
}

// UpdateUser - return: pointer (type User)
func UpdateUser(user User) (User, error) {
	index := GetUserIndex(&user)

	if index == -1 {
		return User{}, errors.New("user not found")
	}

	users[index].Firstname = user.Firstname
	users[index].Lastname = user.Lastname

	return *users[index], nil
}

// GetUserIndex - return: index as integer
func GetUserIndex(user *User) int {
	for i := 0; i < len(users); i++ {
		if users[i].ID == user.ID {
			return i
		}
	}

	return -1
}
