# Technical Architecture: TIO Hybrid Health System

This document outlines the architecture for the **TIO (Tnyx) Adaptive Health OS**. 

---

## 1. High-Level Architecture Layout

The codebase uses a monorepo setup (Turborepo) to structure the frontend interfaces, core services, and heavy backend worker layers:

```
                            +---------------------------------------+
                            |            Turborepo Workspace        |
                            +-------------------+-------------------+
                                                |
          +-------------------------------------+-------------------------------------+
          |                                     |                                     |
+---------v---------+                 +---------v---------+                 +---------v---------+
|    apps/mobile    |                 |     apps/web      |                 |backend/nutrition-s|
|  (Flutter App)    |                 |   (Next.js App)   |                 | (FastAPI Service) |
|  Dart Client      |                 |   TypeScript Web  |                 | Python Core       |
+---------+---------+                 +---------+---------+                 +---------+---------+
          |                                     |                                     |
          | (Direct API / SDK requests)         | (JSON API requests)                 |
          +------------------+------------------+                                     | (API queries)
                             |                                                        |
                             v                                                        |
                  +----------v----------+                                             |
                  |   Supabase Backend  | <-------------------------------------------+
                  |  (Auth, PostgreSQL) | (Checks RLS / Syncs targets)
                  +---------------------+
```

---

## 2. Component Design & Roles

### 2.1. Mobile Client (`apps/mobile`)
* **Technology**: Flutter (Dart)
* **Goal**: Primary user portal for logging health inputs, viewing daily analytics, and interacting with notifications.
* **Architecture**: Feature-First layout inside `lib/src/features/` (e.g. `auth/`, `profile/`, `nutrition/`).
* **Connection**: Communicates directly with Supabase via `supabase_flutter` for real-time CRUD and Auth.

### 2.2. Web Dashboard (`apps/web`)
* **Technology**: Next.js (TypeScript) + React + Tailwind CSS
* **Goal**: Portal for admin management, nutritionist dashboard, and desktop user controls.
* **Connection**: Integrates with Supabase JS SDK for role-based data rendering.

### 2.3. Nutrition Service (`backend/nutrition-service`)
* **Technology**: FastAPI (Python) + Uvicorn
* **Goal**: Macro/nutrition data processing, search, Edamam & FatSecret API connections, and calorie/hydration targets evaluation.
* **Connection**: 
  * Acts as a REST microservice.
  * Accessed by client apps when triggers require external API queries or custom calculations.
  * Direct secure client connections to write calculated targets back to the database.

### 2.4. Storage & DB Layer (`supabase/`)
* **Technology**: PostgreSQL + Row Level Security (RLS)
* **Goal**: Single source of truth for user identities, settings, profiles, and text logs.
* **Security**: RLS rules ensure users can only read/write their own entries.

---

## 3. Core Phase 1 Data Flow

Since Phase 1 is strictly a text-logging application, the data flow is simplified to avoid complex orchestration:

1. **User Sign Up/In**: User authenticates directly via Supabase Auth from the Flutter client.
2. **Onboarding**: User logs age, weight, and height. The client inserts a record into the `profiles` table.
3. **Food/Health Entry**: User types a text log (e.g., "Ate two bananas and a cup of yogurt") on the home dashboard.
4. **Log Submission**: The Flutter client submits a raw record to `text_logs`.
5. **Display**: The history list triggers a select query on `text_logs` ordering by time, returning user submissions instantly.
