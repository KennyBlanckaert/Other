package main

import (
	"fmt"

	"github.com/KennyBlanckaert/Other/tree/master/go/sql_database/persistence"
)

func main() {
	persistence.Connect("<host>", "<password>", "<host>", "3306", "test")
	fmt.Println(persistence.GetUserById(1))
}