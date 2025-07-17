package integration

import (
	"context"
	"testing"
	"time"

	"github.com/jmoiron/sqlx"
	"github.com/stretchr/testify/require"
	"github.com/stretchr/testify/suite"
	"github.com/team-18-project/InnoSync/backend/models"
	"github.com/team-18-project/InnoSync/backend/repo"
)

type UserRepositoryIntegrationSuite struct {
	suite.Suite
	ctx      context.Context
	db       *sqlx.DB
	userRepo *repo.UserRepository
}

func (s *UserRepositoryIntegrationSuite) SetupSuite() {
	s.ctx = context.Background()

	// Initialize database connection
	var err error
	s.db, err = setupDB()
	require.NoError(s.T(), err, "Failed to connect to database")

	// Create repository
	s.userRepo = repo.NewUserRepository(s.db)

	// Initialize database schema
	err = s.createSchema()
	require.NoError(s.T(), err, "Failed to create schema")
}

func (s *UserRepositoryIntegrationSuite) createSchema() error {
	queries := []string{
		`DROP TABLE IF EXISTS user_profile CASCADE`,
		`DROP TABLE IF EXISTS users CASCADE`,
		`CREATE TABLE users (
			id BIGSERIAL PRIMARY KEY,
			email VARCHAR(255) UNIQUE NOT NULL,
			full_name VARCHAR(255) NOT NULL,
			password VARCHAR(255) NOT NULL,
			created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
			last_login TIMESTAMP
		)`,
		`CREATE TABLE user_profile (
			id BIGSERIAL PRIMARY KEY,
			user_id BIGINT UNIQUE NOT NULL,
			bio TEXT,
			FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
		)`,
	}

	for _, query := range queries {
		_, err := s.db.Exec(query)
		if err != nil {
			return err
		}
	}
	return nil
}

func (s *UserRepositoryIntegrationSuite) TearDownSuite() {
	if s.db != nil {
		s.db.Close()
	}
}

func (s *UserRepositoryIntegrationSuite) SetupTest() {
	// Clear data before each test
	_, err := s.db.Exec("TRUNCATE TABLE users, user_profile RESTART IDENTITY CASCADE")
	require.NoError(s.T(), err, "Failed to truncate tables")
}

func (s *UserRepositoryIntegrationSuite) TestCreateUser() {
	user := &models.User{
		Email:    "test" + time.Now().Format("20060102150405") + "@example.com",
		FullName: "Test User",
		Password: "securepassword123",
	}

	s.Run("Success", func() {
		err := s.userRepo.CreateUser(s.ctx, user)
		require.NoError(s.T(), err)
		require.NotZero(s.T(), user.ID)
		require.NotZero(s.T(), user.CreatedAt)

		// Verify in database
		var dbUser models.User
		err = s.db.Get(&dbUser, "SELECT * FROM users WHERE id = $1", user.ID)
		require.NoError(s.T(), err)
		require.Equal(s.T(), user.Email, dbUser.Email)
	})

}

func (s *UserRepositoryIntegrationSuite) TestGetUserByEmail() {
	// Create test user first
	testUser := &models.User{
		Email:    "getuser" + time.Now().Format("20060102150405") + "@example.com",
		FullName: "Get User",
		Password: "testpassword",
	}
	err := s.userRepo.CreateUser(s.ctx, testUser)
	require.NoError(s.T(), err)

	s.Run("ExistingUser", func() {
		user, err := s.userRepo.GetUserByEmail(s.ctx, testUser.Email)
		require.NoError(s.T(), err)
		require.NotNil(s.T(), user)
		require.Equal(s.T(), testUser.Email, user.Email)
		require.Equal(s.T(), testUser.FullName, user.FullName)
	})

	s.Run("NonExistentUser", func() {
		user, err := s.userRepo.GetUserByEmail(s.ctx, "nonexistent"+testUser.Email)
		require.NoError(s.T(), err)
		require.Nil(s.T(), user)
	})
}

func (s *UserRepositoryIntegrationSuite) TestGetUserProfile() {
	// Create test user
	testUser := &models.User{
		Email:    "profileuser" + time.Now().Format("20060102150405") + "@example.com",
		FullName: "Profile User",
		Password: "profilepass",
	}
	err := s.userRepo.CreateUser(s.ctx, testUser)
	require.NoError(s.T(), err)

	s.Run("NoProfile", func() {
		profile, err := s.userRepo.GetUserProfile(s.ctx, testUser.ID)
		require.NoError(s.T(), err)
		require.Nil(s.T(), profile)
	})

	s.Run("WithProfile", func() {
		// Create profile
		_, err = s.db.Exec("INSERT INTO user_profile (user_id, bio) VALUES ($1, $2)",
			testUser.ID, "Test bio")
		require.NoError(s.T(), err)

		profile, err := s.userRepo.GetUserProfile(s.ctx, testUser.ID)
		require.NoError(s.T(), err)
		require.NotNil(s.T(), profile)
		require.Equal(s.T(), testUser.ID, profile.UserID)
		require.Equal(s.T(), "Test bio", *profile.Bio)
	})
}

func TestUserRepositoryIntegration(t *testing.T) {
	if testing.Short() {
		t.Skip("skipping integration test")
	}
	suite.Run(t, new(UserRepositoryIntegrationSuite))
}
