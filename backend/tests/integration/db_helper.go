package integration

import (
	"fmt"
	"log"
	"os"
	"strconv"

	"github.com/jmoiron/sqlx"
	_ "github.com/lib/pq"
)

func setupDB() (*sqlx.DB, error) {
    connStr := fmt.Sprintf(
        "host=%s port=%s user=%s password=%s dbname=%s sslmode=disable",
        os.Getenv("POSTGRES_HOST"),
        os.Getenv("POSTGRES_PORT"),
        os.Getenv("POSTGRES_USER"),
        os.Getenv("POSTGRES_PASSWORD"),
        os.Getenv("POSTGRES_DB"),
    )

	log.Printf("Connecting to database: %s", connStr)

	db, err := sqlx.Connect("postgres", connStr)
	if err != nil {
		log.Printf("Connection failed: %v", err)
		return nil, err
	}

	if err := db.Ping(); err != nil {
		log.Printf("Ping failed: %v", err)
		return nil, err
	}

	log.Println("Database connected successfully")
	return db, nil
}

func getEnv(key, defaultValue string) string {
	value := os.Getenv(key)
	if value == "" {
		return defaultValue
	}
	return value
}
