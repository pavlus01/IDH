package main

import (
	"context"
	"database/sql"
	"fmt"
	"log"
	"os"

	_ "github.com/denisenkom/go-mssqldb"
	"github.com/gocarina/gocsv"
)

var (
	server                 = "127.0.0.1"
	port                   = "1433"
	user                   = "sa"
	password               = "P@ssw0rd"
	database               = "OlympicsDb"
	db                     *sql.DB
	TrustServerCertificate = true
	maxGoroutines          = 100
)

type Athlete struct {
	Id         int    `csv:"ID"`
	Nazwa      string `csv:"Name"`
	Plec       string `csv:"Sex"`
	Wiek       int    `csv:"Age"`
	Wzrost     int    `csv:"Height"`
	Waga       int    `csv:"Weight"`
	Druzyna    string `csv:"Team"`
	Kod        string `csv:"NOC"`
	Zawody     string `csv:"Games"`
	Rok        string `csv:"Year"`
	Tryb       string `csv:"Season"`
	Miasto     string `csv:"City"`
	Sport      string `csv:"Sport"`
	Wydarzenie string `csv:"Event"`
	Medal      string `csv:"Medal"`
}

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

	in, err := os.OpenFile("./Dane/athlete_events.csv", os.O_RDWR|os.O_CREATE, os.ModePerm)
	if err != nil {
		panic(err)
	}
	defer in.Close()

	athletes := []*Athlete{}

	if err := gocsv.UnmarshalFile(in, &athletes); err != nil {
		panic(err)
	}

	guard := make(chan struct{}, maxGoroutines)

	log.Println("Inserting in progess...")
	for _, a := range athletes {
		guard <- struct{}{}
		go func(a *Athlete) {
			InsertTmp(a)
			<-guard
		}(a)
	}
	log.Println("Done")
}

func InsertTmp(athlete *Athlete) (int64, error) {
	ctx := context.Background()

	if db == nil {
		log.Fatal("Connection is not stable")
	}

	tsql := "INSERT INTO OlympicsDb..Tmp VALUES (@Id, @Nazwa, @Plec, @Wiek, @Wzrost, @Waga, @Druzyna, @Kod, @Zawody, @Rok, @Tryb, @Miasto, @Sport, @Wydarzenie, @Medal)"

	result, err := db.ExecContext(
		ctx, tsql,
		sql.Named("Id", athlete.Id),
		sql.Named("Nazwa", athlete.Nazwa),
		sql.Named("Plec", athlete.Plec),
		sql.Named("Wiek", athlete.Wiek),
		sql.Named("Wzrost", athlete.Wzrost),
		sql.Named("Waga", athlete.Waga),
		sql.Named("Druzyna", athlete.Druzyna),
		sql.Named("Kod", athlete.Kod),
		sql.Named("Zawody", athlete.Zawody),
		sql.Named("Rok", athlete.Rok),
		sql.Named("Tryb", athlete.Tryb),
		sql.Named("Miasto", athlete.Miasto),
		sql.Named("Sport", athlete.Sport),
		sql.Named("Wydarzenie", athlete.Wydarzenie),
		sql.Named("Medal", athlete.Medal),
	)

	if err != nil {
		log.Fatalf("Problem with inserting to database: %s", err)
		return -1, err
	}

	return result.LastInsertId()

}
