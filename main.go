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

	for _, a := range athletes {
		InsertTmp(a)
	}

	// file, errFile := os.Open("./Dane/athlete_events.csv")
	// first := true
	// if errFile != nil {
	// 	log.Fatal(err)
	// }

	// scanner := bufio.NewScanner(file)
	// for scanner.Scan() {
	// 	if first {
	// 		first = false
	// 		continue
	// 	}
	// 	res := strings.Replace(scanner.Text(), "1,0", "1.0", -1)
	// 	res = strings.Replace(scanner.Text(), "1,5", "1.5", -1)
	// 	res = strings.Replace(res, "0,0", "0.0", -1)
	// 	res = strings.Replace(res, "5,0", "5.0", -1)
	// 	log.Println(strings.Replace(res, "\"", "", -1))
	// 	InsertTmp(form(strings.Replace(res, "\"", "", -1)))
	// }

	// if err := scanner.Err(); err != nil {
	// 	log.Fatal(err)
	// }

	// file.Close()

	// InsertTmp(1, "A Dijiang", "M", 24, 180, 80, "dsf", "ffd", "cddc", "2024", "vdvdvd", "cdcd", "ccdcdc", "cdcdcd", "cdcd")
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
