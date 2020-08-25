package persistence

import (
	"fmt"
	"database/sql"

	_ "github.com/go-sql-driver/mysql"

	"github.com/KennyBlanckaert/Other/tree/master/go/sql_database/models"
)

var db *sql.DB

func Connect(username string, password string, host string, port string, database string) {
	connectionString := fmt.Sprintf("%s:%s@tcp(%s:%s)/%s", username, password, host, port, database)
	
	var err error
	db, err = sql.Open("mysql", connectionString)
	if err != nil {
		panic(err)
	}
}

func GetUsers() []models.User {
	query := `SELECT * FROM users`

	rows, err := db.Query(query)
	defer rows.Close()

	users := []models.User{}
	for rows.Next() {
		var id int
		var firstname string
		var lastname string
		var street string
		var number int
		var city string

		err = rows.Scan(&id, &firstname, &lastname, &street, &number, &city)
		if err != nil {
			continue
		}

		user := models.User{
			ID: id,
			Firstname: firstname,
			Lastname: lastname,
			Street: street,
			Number:	number,
			City: city,
		}
		users = append(users, user)
	}

	return users
}

func GetUserById(index int) models.User {
	query := "SELECT * FROM users WHERE id = ?"

	row := db.QueryRow(query, index)

	var id int
	var firstname string
	var lastname string
	var street string
	var number int
	var city string

	row.Scan(&id, &firstname, &lastname, &street, &number, &city)
	user := models.User{
		ID: id,
		Firstname: firstname,
		Lastname: lastname,
		Street: street,
		Number: number,
		City: city,
	}

	return user
}

func RemoveUser(id int) error {
	return nil
}

func AddUser(user models.User) error {
	return nil
}