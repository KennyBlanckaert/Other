package main

import (
	"fmt"

	"github.com/KennyBlanckaert/Other/tree/master/go/sql_database/persistence"
)

func main() {
	persistence.Connect("<username>", "<password>", "<host>", "<port>", "<database>")
	
	fmt.Println(persistence.GetUsers())
}