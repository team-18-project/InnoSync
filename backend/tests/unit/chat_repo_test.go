package unit

import (
	"context"
	"regexp"
	"testing"
	"time"

	"github.com/DATA-DOG/go-sqlmock"
	"github.com/jmoiron/sqlx"
	"github.com/stretchr/testify/assert"
	"github.com/team-18-project/InnoSync/backend/models"
	"github.com/team-18-project/InnoSync/backend/repo"
)

func TestGetProjectChat(t *testing.T) {
	// Setup
	db, mock, err := sqlmock.New()
	assert.NoError(t, err)
	defer db.Close()

	repo := repo.NewChatRepository(sqlx.NewDb(db, "postgres"))

	// Mock data
	expectedChat := &models.GroupChat{
		ID:        1,
		ProjectID: 2,
	}

	// Mock expectations
	rows := sqlmock.NewRows([]string{"id", "project_id"}).
		AddRow(expectedChat.ID, expectedChat.ProjectID)

	mock.ExpectQuery(regexp.QuoteMeta(`SELECT * FROM group_chat WHERE project_id = $1`)).
		WithArgs(expectedChat.ProjectID).
		WillReturnRows(rows)

	// Execute
	chat, err := repo.GetProjectChat(context.Background(), expectedChat.ProjectID)

	// Verify
	assert.NoError(t, err)
	assert.Equal(t, expectedChat, chat)
	assert.NoError(t, mock.ExpectationsWereMet())
}

func TestCreateMessage(t *testing.T) {
	// Setup
	db, mock, err := sqlmock.New()
	assert.NoError(t, err)
	defer db.Close()

	repo := repo.NewChatRepository(sqlx.NewDb(db, "postgres"))

	// Test data
	groupChatID := int64(2)
	sentAt := time.Now()
	message := &models.Message{
		SenderID:    1,
		GroupChatID: &groupChatID,
		Content:     "Hello world",
	}

	// Mock expectations
	mock.ExpectQuery(regexp.QuoteMeta(
		`INSERT INTO message (sender_id, group_chat_id, content) VALUES ($1, $2, $3) RETURNING id, sent_at`)).
		WithArgs(message.SenderID, *message.GroupChatID, message.Content).
		WillReturnRows(sqlmock.NewRows([]string{"id", "sent_at"}).
			AddRow(1, sentAt))

	// Execute
	err = repo.CreateMessage(context.Background(), message)

	// Verify
	assert.NoError(t, err)
	assert.Equal(t, int64(1), message.ID)
	assert.Equal(t, sentAt, message.SentAt)
	assert.NoError(t, mock.ExpectationsWereMet())
}

func TestGetChatMessages(t *testing.T) {
	// Setup
	db, mock, err := sqlmock.New()
	assert.NoError(t, err)
	defer db.Close()

	repo := repo.NewChatRepository(sqlx.NewDb(db, "postgres"))

	// Test data
	groupChatID := int64(2)
	sentAt := time.Now()
	expectedMessages := []models.Message{
		{
			ID:          1,
			SenderID:    1,
			GroupChatID: &groupChatID,
			Content:     "Hello",
			SentAt:      sentAt,
		},
		{
			ID:          2,
			SenderID:    1,
			GroupChatID: &groupChatID,
			Content:     "World",
			SentAt:      sentAt.Add(time.Minute),
		},
	}

	// Mock expectations
	rows := sqlmock.NewRows([]string{"id", "sender_id", "group_chat_id", "content", "sent_at"})
	for _, msg := range expectedMessages {
		rows.AddRow(msg.ID, msg.SenderID, *msg.GroupChatID, msg.Content, msg.SentAt)
	}

	mock.ExpectQuery(regexp.QuoteMeta(
		`SELECT * FROM message WHERE group_chat_id = $1 ORDER BY sent_at ASC`)).
		WithArgs(groupChatID).
		WillReturnRows(rows)

	// Execute
	messages, err := repo.GetChatMessages(context.Background(), groupChatID)

	// Verify
	assert.NoError(t, err)
	assert.Equal(t, expectedMessages, messages)
	assert.NoError(t, mock.ExpectationsWereMet())
}
