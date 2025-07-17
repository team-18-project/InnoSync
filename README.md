# InnoSync Mobile App

A full-stack, collaborative project management platform for innovators, teams, and talent. This monorepo contains both the backend RESTful API (Go, Gin, PostgreSQL) and the cross-platform mobile frontend (Flutter).

---

## Project Overview

**InnoSync:** InnoSync & team-matching platform connecting talent and projects in university communities.
**Features:**
- Register, authenticate, and manage profiles
- Create and manage projects and roles
- Apply for project roles and track applications
- Send and respond to invitations

---

## Architecture

```
InnoSyncMobileApp/
├── backend/   # Go, Gin, PostgreSQL REST API
└── frontend/  # Flutter mobile app (Android, iOS, Web, Desktop)
```

- **Backend:** Go, Gin, PostgreSQL, Docker
- **Frontend:** Flutter (Dart)
- **DevOps:** Github Actions CI/CD
---

## Features

### Backend
- JWT authentication (access/refresh tokens)
- User profile management (with file uploads)
- Project and role management
- Application and invitation system
- RESTful API, CORS, Dockerized

### Frontend
- Modern Flutter UI
- User login/signup
- Project discovery and application
- Profile creation and editing
- Team and invitation management

---

## Project Structure

```
backend/   # API, business logic, database, Docker
frontend/  # Flutter app, widgets, screens, models
```

---

## Setup Instructions

### Prerequisites
- **Backend:** Go 1.21+, PostgreSQL 12+, Docker & Docker Compose (optional)
- **Frontend:** Flutter SDK 3.8+, Dart 3.8+

### Backend Setup

#### 1. Local Development

- Install Go and PostgreSQL
- Copy `backend/config.yaml` and edit as needed:
  ```yaml
  server:
    port: 3000
    host: "0.0.0.0"
    mode: "debug"
  database:
    host: "localhost"
    port: 5432
    user: "postgres"
    password: "postgres"
    dbname: "innosync"
    sslmode: "disable"
  jwt:
    secret_key: "your-secret-key-change-this-in-production"
    access_token_ttl: "15m"
    refresh_token_ttl: "168h"
  upload:
    max_file_size: 10485760
    upload_dir: "uploads"
    allowed_extensions: [".jpg", ".jpeg", ".png", ".pdf", ".doc", ".docx"]
  ```
- Install dependencies:
  ```bash
  cd backend
  go mod download
  ```
- Run database migrations (if any)
- Start the server:
  ```bash
  go run main.go
  ```
- API available at `http://localhost:3000/api/v1`

#### 2. Docker Compose (Recommended)

- Ensure Docker and Docker Compose are installed
- From the project root:
  ```bash
  docker-compose up -d
  ```
- Services:
  - **db:** PostgreSQL (port 5432)
  - **backend:** Go API (port 3000)
  - **adminer:** DB UI (port 3001)

---

### Frontend Setup

- Install [Flutter SDK](https://docs.flutter.dev/get-started/install)
- From the `frontend` directory:
  ```bash
  flutter pub get
  flutter run
  ```
- To run on web/desktop, see [Flutter docs](https://docs.flutter.dev/)

#### Linting & Code Quality
- Uses `flutter_lints` (see `analysis_options.yaml`)
- Run:
  ```bash
  flutter analyze
  ```

---

## API Documentation
- We have our swagger UI api documentation along with an API .md file you can accesss it through this [Link](https://github.com/team-18-project/InnoSync/blob/main/backend/README.md)

---


## Database Documentation
-This is our database schema and documentation [Link](https://github.com/team-18-project/InnoSync/blob/main/db/DB_design.md)
![Database Schema](https://raw.githubusercontent.com/team-18-project/InnoSync/refs/heads/main/db/DB_diagram.png)

---

## Contributions

- Stefan Farafonov: Team lead and management, Flutter Frontend Implementation
- Ahmed Baha Eddine Alimi: Figma Design, API implementation and documentation, Product Conception
- Aigul Farkhetdinovaa: Database Implementation, CI/CD pipeline setup, Unit Tests Implementation
- Arifzhan Narimov: Flutter Frontend Implementation
- Roman Voronin: Endpoint Connection

---

## License

MIT License