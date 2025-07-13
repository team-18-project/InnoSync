package models

import (
	"time"
)

type User struct {
	ID        int64     `json:"id" db:"id"`
	Email     string    `json:"email" db:"email"`
	FullName  string    `json:"full_name" db:"full_name"`
	Password  string    `json:"-" db:"password"`
	CreatedAt time.Time `json:"created_at" db:"created_at"`
}

type EducationEnum string

const (
	EducationNoDegree EducationEnum = "NO_DEGREE"
	EducationBachelor EducationEnum = "BACHELOR"
	EducationMaster   EducationEnum = "MASTER"
	EducationPhD      EducationEnum = "PHD"
)

type ExpertiseLevelEnum string

const (
	ExpertiseLevelEntry      ExpertiseLevelEnum = "ENTRY"
	ExpertiseLevelJunior     ExpertiseLevelEnum = "JUNIOR"
	ExpertiseLevelMid        ExpertiseLevelEnum = "MID"
	ExpertiseLevelSenior     ExpertiseLevelEnum = "SENIOR"
	ExpertiseLevelResearcher ExpertiseLevelEnum = "RESEARCHER"
)

type InvitationStatusEnum string

const (
	InvitationStatusInvited  InvitationStatusEnum = "INVITED"
	InvitationStatusAccepted InvitationStatusEnum = "ACCEPTED"
	InvitationStatusDeclined InvitationStatusEnum = "DECLINED"
	InvitationStatusRevoked  InvitationStatusEnum = "REVOKED"
)

type ApplicationStatusEnum string

const (
	ApplicationStatusPending     ApplicationStatusEnum = "PENDING"
	ApplicationStatusUnderReview ApplicationStatusEnum = "UNDER_REVIEW"
	ApplicationStatusAccepted    ApplicationStatusEnum = "ACCEPTED"
	ApplicationStatusRejected    ApplicationStatusEnum = "REJECTED"
	ApplicationStatusWithdrawn   ApplicationStatusEnum = "WITHDRAWN"
)
