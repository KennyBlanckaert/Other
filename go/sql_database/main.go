package main

import (
	"github.com/KennyBlanckaert/Other/tree/master/go/sql_database/persistence"
)

func main() {
	persistence.Connect("<username>", "<password>", "<host>", "3306", "test")
	persistence.GetUsers()
}