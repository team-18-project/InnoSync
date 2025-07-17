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

## 📄 API Documentation

Access and interact with our API seamlessly:

- **Swagger UI** – Explore and test endpoints interactively.
- **Markdown Guide** – Full API spec in [backend/README.md](https://github.com/team-18-project/InnoSync/blob/main/backend/README.md).

### 🔍 API Highlights

- **Authentication**
  - JWT based with secure login and token refresh.
- **Core Endpoints**
  - **Users**: register, login, profile management.
  - **Projects**: create, read, update, delete; team invites.
---

## 🗄️ Database Schema & Design

Visual and descriptive overview available:

- **Schema Diagram**
  ![Database Schema](https://raw.githubusercontent.com/team-18-project/InnoSync/refs/heads/main/db/DB_diagram.png)
- **Detailed ERD & Tables** – See [db/DB_design.md](https://github.com/team-18-project/InnoSync/blob/main/db/DB_design.md)
  - Tables: `users`, `projects`, `tasks`, `comments`, `notifications`, `activities`, etc.
  - Relationships: one-to-many (users→projects, projects→tasks), many-to-many (users↔projects via project_team join table).

---

---

## 🧠 Product Design & UX Research

Comprehensive user-research-backed features:

- In-depth findings and validation in [Product Design & UX Research](https://www.figma.com/design/islrijonPzZEUrBi9NgV94/UX-UI-Mid?node-id=47-31994&t=bATNSWtlbjcDZmov-1)
- Highlights:
  - **User Pain Points** – Collaboration friction, task visibility gaps.
  - **Proposed Solutions** – Real-time updates, shared project dashboards, invitation workflows.
  - **Feature Roadmap** – Prioritized through user feedback and impact analysis.
  - **Wireframes & Mockups** – Visual representations of key screens and user flows.
- High-Fideliy Design [Link](https://www.figma.com/design/qDq1rHa8D5f1AlJtMBb0rz/High-Fi-design-InnoSync?t=5BQsZTzFq7z2nK77-0)

---

## Contributions

- Stefan Farafonov: Team lead and management, Flutter Frontend Implementation
- Ahmed Baha Eddine Alimi: Figma Design, API implementation and documentation, Product Conception
- Aigul Farkhetdinovaa: Database Implementation, CI/CD pipeline setup, Unit Tests Implementation
- Arifzhan Narimov: Flutter Frontend Implementation
- Roman Voronin: Endpoint Connection

---

## 🌐 Web Application Access

In addition to the mobile app, we also offer a **Web Application** with full project management functionalities.
You can access it here: [https://innosync.duckdns.org](https://innosync.duckdns.org)

The web app ensures a seamless experience across both platforms, with plans for advanced account syncing and unified notifications.

---

## 🚀 Future Plans

- **Quick Syncing (AI-Powered Smart Matching)**
  - AI-driven recommendations for team matching and project collaborations.

- **Cross-Platform Account Syncing**
  - Seamless integration between mobile and web applications for unified access and synchronized notifications.

---
## License

MIT License
