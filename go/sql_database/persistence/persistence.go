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
	query := `SELECT * FROM user`

	rows, err := db.Query(query)
	defer rows.Close()

	users := []models.User{}
	for rows.Next() {
		var id int
		var firstname string
		var lastname string
		var address string

		err = rows.Scan(&id, &firstname, &lastname, &address)
		if err != nil {
			continue
		}

		user := models.User{
			ID: id,
			Firstname: firstname,
			Lastname: lastname,
			Address: address,
		}
		users = append(users, user)
	}

	return users
}

func GetUserById(id int) *models.User {
	return nil
}

func RemoveUser(id int) error {
	return nil
}

func AddUser(user models.User) error {
	return nil
}