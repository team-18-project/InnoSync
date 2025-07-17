package unit

import (
	"context"
	"database/sql"
	"regexp"
	"testing"
	"time"

	"github.com/DATA-DOG/go-sqlmock"
	"github.com/jmoiron/sqlx"
	"github.com/stretchr/testify/assert"
	"github.com/team-18-project/InnoSync/backend/models"
	"github.com/team-18-project/InnoSync/backend/repo"
)

func TestCreateUser(t *testing.T) {
	db, mock, err := sqlmock.New()
	assert.NoError(t, err)
	defer db.Close()

	sqlxDB := sqlx.NewDb(db, "postgres")
	repo := repo.NewUserRepository(sqlxDB)

	user := &models.User{
		Email:    "test@example.com",
		FullName: "Test User",
		Password: "hashedpassword",
	}

	t.Run("Success", func(t *testing.T) {
		createdAt := time.Now()
		mock.ExpectQuery(regexp.QuoteMeta(
			`INSERT INTO users (email, full_name, password) VALUES ($1, $2, $3) RETURNING id, created_at`)).
			WithArgs(user.Email, user.FullName, user.Password).
			WillReturnRows(sqlmock.NewRows([]string{"id", "created_at"}).AddRow(1, createdAt))

		err := repo.CreateUser(context.Background(), user)
		assert.NoError(t, err)
		assert.Equal(t, int64(1), user.ID)
		assert.Equal(t, createdAt, user.CreatedAt)
	})

	t.Run("Error", func(t *testing.T) {
		mock.ExpectQuery(regexp.QuoteMeta(
			`INSERT INTO users (email, full_name, password) VALUES ($1, $2, $3) RETURNING id, created_at`)).
			WithArgs(user.Email, user.FullName, user.Password).
			WillReturnError(sql.ErrConnDone)

		err := repo.CreateUser(context.Background(), user)
		assert.Error(t, err)
		assert.Equal(t, sql.ErrConnDone, err)
	})

	assert.NoError(t, mock.ExpectationsWereMet())
}

func TestGetUserByEmail(t *testing.T) {
	db, mock, err := sqlmock.New()
	assert.NoError(t, err)
	defer db.Close()

	sqlxDB := sqlx.NewDb(db, "postgres")
	repo := repo.NewUserRepository(sqlxDB)

	email := "test@example.com"
	expectedUser := &models.User{
		ID:        1,
		Email:     email,
		FullName:  "Test User",
		Password:  "hashedpassword",
		CreatedAt: time.Now(),
	}

	t.Run("Success", func(t *testing.T) {
		rows := sqlmock.NewRows([]string{"id", "email", "full_name", "password", "created_at"}).
			AddRow(expectedUser.ID, expectedUser.Email, expectedUser.FullName, expectedUser.Password, expectedUser.CreatedAt)

		mock.ExpectQuery(regexp.QuoteMeta(`SELECT * FROM users WHERE email = $1`)).
			WithArgs(email).
			WillReturnRows(rows)

		user, err := repo.GetUserByEmail(context.Background(), email)
		assert.NoError(t, err)
		assert.Equal(t, expectedUser, user)
	})

	t.Run("NotFound", func(t *testing.T) {
		mock.ExpectQuery(regexp.QuoteMeta(`SELECT * FROM users WHERE email = $1`)).
			WithArgs(email).
			WillReturnError(sql.ErrNoRows)

		user, err := repo.GetUserByEmail(context.Background(), email)
		assert.NoError(t, err)
		assert.Nil(t, user)
	})

	t.Run("Error", func(t *testing.T) {
		mock.ExpectQuery(regexp.QuoteMeta(`SELECT * FROM users WHERE email = $1`)).
			WithArgs(email).
			WillReturnError(sql.ErrConnDone)

		user, err := repo.GetUserByEmail(context.Background(), email)
		assert.Error(t, err)
		assert.Equal(t, sql.ErrConnDone, err)

		// Either expect nil or an empty User struct depending on your implementation
		// Option 1: If your implementation returns nil
		// assert.Nil(t, user)

		// Option 2: If your implementation returns empty User
		assert.NotNil(t, user)             // Check it's not nil
		assert.Equal(t, int64(0), user.ID) // Check it's empty
	})

	assert.NoError(t, mock.ExpectationsWereMet())
}
