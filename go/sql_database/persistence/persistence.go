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

func GetUsers() {
	query := `SELECT * FROM user`

	rows, err := db.Query(query)
	defer rows.Close()

	for rows.Next() {
		var id int
		var firstname string
		var lastname string
		var address string

		err = rows.Scan(&id, &firstname, &lastname, &address)

		fmt.Println(id, firstname, lastname, address)
	}

	err = rows.Err()
	if err != nil {
		panic(err)
	}
}

func GetUserById(id int) {

}

func RemoveUser(id int) {

}

func AddUser(user models.User) {

}