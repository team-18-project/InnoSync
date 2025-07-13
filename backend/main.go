package backend

import (
	_ "github.com/jmoiron/sqlx"
	_ "github.com/lib/pq"
	_ "github.com/team-18-project/InnoSync/backend/repo"
)

func main() {
	// db := sqlx.MustConnect("postgres", "db_connection_string")

	// userRepo := repo.NewUserRepository(db)
	// projectRepo := repo.NewProjectRepository(db)
	// recruitmentRepo := repo.NewRecruitmentRepository(db)
	// chatRepo := repo.NewChatRepository(db)

}
