package models

import "time"

type UserProfile struct {
	ID             int64               `json:"id" db:"id"`
	UserID         int64               `json:"user_id" db:"user_id"`
	Telegram       *string             `json:"telegram,omitempty" db:"telegram"`
	GitHub         *string             `json:"github,omitempty" db:"github"`
	Bio            *string             `json:"bio,omitempty" db:"bio"`
	Position       *string             `json:"position,omitempty" db:"position"`
	Education      *EducationEnum      `json:"education,omitempty" db:"education"`
	Expertise      *string             `json:"expertise,omitempty" db:"expertise"`
	ExpertiseLevel *ExpertiseLevelEnum `json:"expertise_level,omitempty" db:"expertise_level"`
	Resume         *string             `json:"resume,omitempty" db:"resume"`
}

type WorkExperience struct {
	ID            int64      `json:"id" db:"id"`
	UserProfileID int64      `json:"user_profile_id" db:"user_profile_id"`
	StartDate     time.Time  `json:"start_date" db:"start_date"`
	EndDate       *time.Time `json:"end_date,omitempty" db:"end_date"`
	Position      string     `json:"position" db:"position"`
	Company       string     `json:"company" db:"company"`
	Description   *string    `json:"description,omitempty" db:"description"`
}

type Technology struct {
	ID   int64  `json:"id" db:"id"`
	Name string `json:"name" db:"name"`
}
