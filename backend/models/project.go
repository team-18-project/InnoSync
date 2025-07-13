package models

import "time"

type Project struct {
	ID          int64     `json:"id" db:"id"`
	RecruiterID int64     `json:"recruiter_id" db:"recruiter_id"`
	Title       string    `json:"title" db:"title"`
	Description *string   `json:"description,omitempty" db:"description"`
	TeamSize    int       `json:"team_size" db:"team_size"`
	CreatedAt   time.Time `json:"created_at" db:"created_at"`
}

type ProjectRole struct {
	ID             int64               `json:"id" db:"id"`
	ProjectID      int64               `json:"project_id" db:"project_id"`
	RoleName       string              `json:"role_name" db:"role_name"`
	ExpertiseLevel *ExpertiseLevelEnum `json:"expertise_level,omitempty" db:"expertise_level"`
	Technologies   *string             `json:"technologies,omitempty" db:"technologies"`
}
