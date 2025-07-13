package models

import "time"

type Invitation struct {
	ID            int64                `json:"id" db:"id"`
	ProjectRoleID int64                `json:"project_role_id" db:"project_role_id"`
	UserID        int64                `json:"user_id" db:"user_id"`
	Status        InvitationStatusEnum `json:"status" db:"status"`
	SentAt        time.Time            `json:"sent_at" db:"sent_at"`
	RespondedAt   *time.Time           `json:"responded_at,omitempty" db:"responded_at"`
}

type RoleApplication struct {
	ID            int64                 `json:"id" db:"id"`
	UserID        int64                 `json:"user_id" db:"user_id"`
	ProjectRoleID int64                 `json:"project_role_id" db:"project_role_id"`
	Status        ApplicationStatusEnum `json:"status" db:"status"`
	AppliedAt     time.Time             `json:"applied_at" db:"applied_at"`
	UpdatedAt     time.Time             `json:"updated_at" db:"updated_at"`
}
