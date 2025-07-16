package models_test

import (
	"testing"
	"time"

	"github.com/stretchr/testify/assert"
	"github.com/team-18-project/InnoSync/backend/models"
)

func TestUser_IsValid(t *testing.T) {
	t.Run("Valid user", func(t *testing.T) {
		user := models.User{Email: "a@b.com", FullName: "Test", Password: "pass"}
		assert.True(t, user.IsValid())
	})
	t.Run("Missing email", func(t *testing.T) {
		user := models.User{FullName: "Test", Password: "pass"}
		assert.False(t, user.IsValid())
	})
}

func TestRefreshToken_IsExpired(t *testing.T) {
	t.Run("Not expired", func(t *testing.T) {
		rt := models.RefreshToken{ExpiryDate: time.Now().Add(1 * time.Hour)}
		assert.False(t, rt.IsExpired())
	})
	t.Run("Expired", func(t *testing.T) {
		rt := models.RefreshToken{ExpiryDate: time.Now().Add(-1 * time.Hour)}
		assert.True(t, rt.IsExpired())
	})
}

func TestProject_IsValid(t *testing.T) {
	t.Run("Valid project", func(t *testing.T) {
		proj := models.Project{Title: "Test", RecruiterID: 1}
		assert.True(t, proj.IsValid())
	})
	t.Run("Missing title", func(t *testing.T) {
		proj := models.Project{RecruiterID: 1}
		assert.False(t, proj.IsValid())
	})
}

func TestProjectRole_IsValid(t *testing.T) {
	t.Run("Valid role", func(t *testing.T) {
		role := models.ProjectRole{RoleName: "Dev", ProjectID: 1}
		assert.True(t, role.IsValid())
	})
	t.Run("Missing role name", func(t *testing.T) {
		role := models.ProjectRole{ProjectID: 1}
		assert.False(t, role.IsValid())
	})
}

func TestTechnology_IsValid(t *testing.T) {
	t.Run("Valid tech", func(t *testing.T) {
		tech := models.Technology{Name: "Go"}
		assert.True(t, tech.IsValid())
	})
	t.Run("Missing name", func(t *testing.T) {
		tech := models.Technology{}
		assert.False(t, tech.IsValid())
	})
}

func TestWorkExperience_IsValid(t *testing.T) {
	t.Run("Valid work exp", func(t *testing.T) {
		we := models.WorkExperience{Position: "Dev", Company: "Inc", UserProfileID: 1}
		assert.True(t, we.IsValid())
	})
	t.Run("Missing position", func(t *testing.T) {
		we := models.WorkExperience{Company: "Inc", UserProfileID: 1}
		assert.False(t, we.IsValid())
	})
}
