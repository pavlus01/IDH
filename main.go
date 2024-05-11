package main

import (
	"bufio"
	"context"
	"database/sql"
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"

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
	counter                = 1
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

	file, errFile := os.Open("./Dane/athlete_events.csv")
	first := true
	if errFile != nil {
		log.Fatal(err)
	}

	scanner := bufio.NewScanner(file)

	for scanner.Scan() {
		if first {
			first = false
			continue
		}
		InsertTmp(form(strings.Replace(scanner.Text(), "\"", "", -1)))
	}

	if err := scanner.Err(); err != nil {
		log.Fatal(err)
	}

	file.Close()

	// InsertTmp(1, "A Dijiang", "M", 24, 180, 80, "dsf", "ffd", "cddc", "2024", "vdvdvd", "cdcd", "ccdcdc", "cdcdcd", "cdcd")
}

func form(line string) (nazwa, plec string, wiek, wzrost, waga int, druzyna, kod, zawody, rok, tryb, miasto, sport, wydarzenie, medal string) {
	data := strings.Split(line, ",")
	Wiek, _ := strconv.Atoi(data[3])
	log.Println(Wiek)
	Wzrost, _ := strconv.Atoi(data[4])
	Waga, _ := strconv.Atoi(data[5])
	log.Printf("Id: %v, Nazwa: %s, Plec: %s", 32, data[1], data[2])
	return data[1], data[2], Wiek, Wzrost, Waga, data[6], data[7],
		data[8], data[9], data[10], data[11], data[12], data[13], data[14]
}

func InsertTmp(nazwa, plec string, wiek, wzrost, waga int, druzyna, kod, zawody, rok, tryb, miasto, sport, wydarzenie, medal string) (int64, error) {
	ctx := context.Background()

	if db == nil {
		log.Fatal("Connection is not stable")
	}

	tsql := "INSERT INTO OlympicsDb..Tmp VALUES (@Id, @Nazwa, @Plec, @Wiek, @Wzrost, @Waga, @Druzyna, @Kod, @Zawody, @Rok, @Tryb, @Miasto, @Sport, @Wydarzenie, @Medal)"

	result, err := db.ExecContext(
		ctx, tsql,
		sql.Named("Id", counter),
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

	counter += 1
	return result.LastInsertId()

}
