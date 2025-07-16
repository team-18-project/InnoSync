package integration

import (
	"bytes"
	"context"
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"os"
	"testing"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/jmoiron/sqlx"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/suite"
	"github.com/team-18-project/InnoSync/backend/config"
	"github.com/team-18-project/InnoSync/backend/handlers"
	"github.com/team-18-project/InnoSync/backend/models"
	_ "github.com/team-18-project/InnoSync/backend/repo"
	"github.com/team-18-project/InnoSync/backend/services"
	"github.com/team-18-project/InnoSync/backend/utils"
	"github.com/testcontainers/testcontainers-go"
	"github.com/testcontainers/testcontainers-go/wait"
)

type AuthIntegrationTestSuite struct {
	suite.Suite
	db           *sqlx.DB
	container    testcontainers.Container
	authHandler  *handlers.AuthHandler
	router       *gin.Engine
	tokenManager *utils.TokenManager
}

func (suite *AuthIntegrationTestSuite) SetupSuite() {
	ctx := context.Background()
	req := testcontainers.ContainerRequest{
		Image:        "postgres:14",
		ExposedPorts: []string{"5432/tcp"},
		Env: map[string]string{
			"POSTGRES_USER":     "test",
			"POSTGRES_PASSWORD": "test",
			"POSTGRES_DB":       "test_db",
		},
		WaitingFor: wait.ForLog("database system is ready to accept connections"),
	}
	container, err := testcontainers.GenericContainer(ctx, testcontainers.GenericContainerRequest{
		ContainerRequest: req,
		Started:          true,
	})
	suite.Require().NoError(err)

	host, err := container.Host(ctx)
	suite.Require().NoError(err)

	port, err := container.MappedPort(ctx, "5432")
	suite.Require().NoError(err)

	connStr := "user=test password=test dbname=test_db host=" + host + " port=" + port.Port() + " sslmode=disable"
	db, err := sqlx.Connect("postgres", connStr)
	suite.Require().NoError(err)

	// Run migrations
	migration, err := os.ReadFile("../../migrations/001_init_schema.up.sql")
	suite.Require().NoError(err)
	_, err = db.Exec(string(migration))
	suite.Require().NoError(err)

	suite.db = db
	suite.container = container

	// Setup config for TokenManager
	cfg := &config.Config{
		JWT: config.JWTConfig{
			SecretKey:       "test-secret",
			AccessTokenTTL:  3600 * time.Second,
			RefreshTokenTTL: 86400 * time.Second,
		},
	}
	tokenManager := utils.NewTokenManager(cfg)
	suite.tokenManager = tokenManager

	authService := services.NewAuthService(db, tokenManager)
	suite.authHandler = handlers.NewAuthHandler(authService)

	// Setup router
	suite.router = gin.Default()
	suite.authHandler.RegisterRoutes(suite.router.Group("/api"))
}

func (suite *AuthIntegrationTestSuite) TearDownSuite() {
	suite.db.Close()
	suite.container.Terminate(context.Background())
}

func (suite *AuthIntegrationTestSuite) TestSignupLoginFlow() {
	// Signup
	signupReq := models.SignupRequest{
		Email:    "test@example.com",
		Password: "password123",
		FullName: "Test User",
	}
	body, _ := json.Marshal(signupReq)

	req, _ := http.NewRequest("POST", "/api/auth/signup", bytes.NewBuffer(body))
	req.Header.Set("Content-Type", "application/json")

	w := httptest.NewRecorder()
	suite.router.ServeHTTP(w, req)

	assert.Equal(suite.T(), http.StatusCreated, w.Code)

	// Login
	loginReq := models.LoginRequest{
		Email:    "test@example.com",
		Password: "password123",
	}
	body, _ = json.Marshal(loginReq)

	req, _ = http.NewRequest("POST", "/api/auth/login", bytes.NewBuffer(body))
	req.Header.Set("Content-Type", "application/json")

	w = httptest.NewRecorder()
	suite.router.ServeHTTP(w, req)

	assert.Equal(suite.T(), http.StatusOK, w.Code)

	var authResponse models.AuthResponse
	err := json.Unmarshal(w.Body.Bytes(), &authResponse)
	assert.NoError(suite.T(), err)
	assert.NotEmpty(suite.T(), authResponse.Tokens.AccessToken)
	assert.NotEmpty(suite.T(), authResponse.Tokens.RefreshToken)
}

func TestAuthIntegrationTestSuite(t *testing.T) {
	suite.Run(t, new(AuthIntegrationTestSuite))
}
