package main

import (
	"context"
	"database/sql"
	"fmt"
	"log"

	_ "github.com/denisenkom/go-mssqldb"
)

var (
	server                 = "127.0.0.1"
	port                   = "1433"
	user                   = "sa"
	password               = "P@ssw0rd"
	database               = "OlympicsDb"
	TrustServerCertificate = true
	db                     *sql.DB
)

func main() {
	var err error

	connString := fmt.Sprintf("sqlserver://%s:%s@%s:%s?database=%s;",
		user, password, server, port, database)

	db, err = sql.Open("sqlserver", connString)
	if err != nil {
		log.Fatal("Error creating connection pool: ", err.Error())
	}

	log.Println("Connected")
	defer db.Close()

	InsertTmp(1, "A Dijiang", "M", 24, 180, 80, "dsf", "ffd", "cddc", "2024", "vdvdvd", "cdcd", "ccdcdc", "cdcdcd", "cdcd")
}

func InsertTmp(id int, nazwa, plec string, wiek, wzrost, waga int, druzyna, kod, zawody, rok, tryb, miasto, sport, wydarzenie, medal string) (int64, error) {
	ctx := context.Background()

	if db == nil {
		log.Fatal("Connection is not stable")
	}

	tsql := "INSERT INTO OlympicsDb..Tmp VALUES (@Id, @Nazwa, @Plec, @Wiek, @Wzrost, @Waga, @Druzyna, @Kod, @Zawody, @Rok, @Tryb, @Miasto, @Sport, @Wydarzenie, @Medal)"

	result, err := db.ExecContext(
		ctx, tsql,
		sql.Named("Id", id),
		sql.Named("Nazwa", nazwa),
		sql.Named("Plec", plec),
		sql.Named("Wiek", wiek),
		sql.Named("Wzrost", wzrost),
		sql.Named("Waga", waga),
		sql.Named("Druzyna", druzyna),
		sql.Named("Kod", kod),
		sql.Named("Zawody", zawody),
		sql.Named("Rok", rok),
		sql.Named("Tryb", tryb),
		sql.Named("Miasto", miasto),
		sql.Named("Sport", sport),
		sql.Named("Wydarzenie", wydarzenie),
		sql.Named("Medal", medal),
	)

	if err != nil {
		log.Fatalf("Problem with inserting to database: %s", err)
		return -1, err
	}

	return result.LastInsertId()

}
