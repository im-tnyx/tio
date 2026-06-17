# Project Roadmap: TIO Adaptive Health OS

This document details the phased release plan for the TIO ecosystem. 

---

## 📅 Phase-by-Phase Release Milestones

### 🟢 Phase 1: MVP (Profile Onboarding & Text Logging) [Current]
* **Goal**: Launch the core database sync loop using the Flutter mobile app and Supabase.
* **Scope Constraints**: No workouts, no AI processing, no automatic recommendations.
* **Deliverables**:
  * **Auth & Profiles**: Signup/Signin screens + onboarding screens (age, weight, height preferences).
  * **Text Logger**: Text input field on the main dashboard for typing daily food/health logs.
  * **History Feed**: List of previous text submissions sorted chronologically with pull-to-refresh.
  * **Infrastructure**: Turborepo workspace configurations, dev env setup, and database migrations.
* **Definition of Done**:
  * User can sign up, log their profile metrics, write a text log, and see it sync to the Supabase database.

### 🟡 Phase 2: AI Parsing & Basic Recommendations
* **Goal**: Add intelligence to unstructured logs.
* **Scope**: Introduce Python FastAPI backend (AI Service) and OpenAI/Gemini APIs.
* **Deliverables**:
  * **AI Parsing**: Python microservice parses raw text logs (e.g. "I ate 2 eggs and toast") into structured calorie/macro metrics (Carbs, Protein, Fats).
  * **Dynamic Dashboard**: Display target metrics progress rings (consumed vs remaining).
  * **FastAPI Microservice**: Deploy Python API endpoints for text parsing and prompt routing.

### 🟡 Phase 3: Workout Logging & Core Routines
* **Goal**: Expand tracking capabilities to training sessions.
* **Deliverables**:
  * **Workout Tracker**: Sets, reps, weight, RPE, and resting time logging.
  * **Workout Library**: Preconfigured exercise routines.
  * **Database expansion**: Add tables for `workouts`, `routines`, and `exercise_logs`.

### 🟡 Phase 4: Dynamic Calorie & Recovery Adaptation
* **Goal**: Make plans adaptive based on user performance.
* **Deliverables**:
  * **TDEE Engine**: Calculate dynamic TDEE based on moving weight averages and caloric logs.
  * **Plateau Mitigation**: Suggestions for deload weeks, diet breaks, or refeed days.
  * **Integrations**: Support wearable sync (steps, heart rate, sleep).

### 🟡 Phase 5: Multimodal & Computer Vision
* **Goal**: Advanced input logging.
* **Deliverables**:
  * **OCR Label Scanning**: Scan nutrition labels to extract macros.
  * **Photo Log**: Generate calorie estimates from uploaded food photos.

---

## 📋 Phase 1 Execution Checklist (Sprint tasks)

- [ ] Initialize Turborepo configurations at root workspace (`pnpm-workspace.yaml`, `package.json`, `turbo.json`).
- [ ] Connect Flutter (`apps/mobile`) to local Supabase client SDK.
- [ ] Establish Supabase PostgreSQL schema (`profiles` and `text_logs` tables).
- [ ] Implement Flutter registration, login, and onboarding screens.
- [ ] Implement Flutter main dashboard with text-input submission block.
- [ ] Implement Flutter list history feed for text logs with pull-to-refresh support.
