# Project Progress & Status Report

This document tracks the integration, configuration, and implementation status of the **Tio Ecosystem** (monorepo, database schemas, mobile app, and backend services).

## 📊 Summary of Completed Work

### 1. Monorepo Restructuring & Workspace Config
* **Target Layout**: Separated client apps and backend microservices.
  * Backend services now live in [backend/](file:///g:/Tio/backend/) (e.g., [backend/nutrition-service/](file:///g:/Tio/backend/nutrition-service/)).
  * Client apps live in [apps/](file:///g:/Tio/apps/) (e.g., [apps/mobile/](file:///g:/Tio/apps/mobile/)).
* **Workspace Setup**: Configured [pnpm-workspace.yaml](file:///g:/Tio/pnpm-workspace.yaml) to track `apps/*` and `backend/*`.
* **Build Pipeline**: Configured Turborepo in [turbo.json](file:///g:/Tio/turbo.json) to orchestrate parallel builds and cache builds for rapid compilation.
* **Pnpm Store Relocation**: Configured `.npmrc` to route the global package store to [G:\dev\.pnpm-store](file:///g:/Tio/dev/.pnpm-store) instead of the root `G:\.pnpm-store`.

---

### 2. Supabase Integration & Schema
* **Database Models**: Created migrations ([init_schema.sql](file:///g:/Tio/supabase/migrations/20260616000000_init_schema.sql)) defining the core tables:
  * `profiles`: Storing user details like age, height, weight, activity levels, and goals.
  * `text_logs`: Database records for nutrition/meal logs typed by users.
  * `nutrition_targets`: Daily targets for calories, macros (protein, carbs, fat, fiber), water, and steps.
* **Security & Row Level Security (RLS)**: Policies are set up to ensure users can only access their own data.
* **Automated Seed/Triggers**: Added database triggers that automatically populate a new user's profile and default targets (e.g., 2000 kcal, 130g protein, 10000 steps) upon auth account creation.

---

### 3. Flutter Mobile Application (`apps/mobile`)
Implemented core pages and widgets inside [apps/mobile/lib/src/features/](file:///g:/Tio/apps/mobile/lib/src/features/):
* **Auth Page** ([login_screen.dart](file:///g:/Tio/apps/mobile/lib/src/features/auth/presentation/screen/login_screen.dart)): Support for Supabase auth sign-in and sign-up with a **Quick Dev Mode (Mock Mode)** bypass button to support offline development.
* **Onboarding Page** ([onboarding_screen.dart](file:///g:/Tio/apps/mobile/lib/src/features/onboarding/presentation/screen/onboarding_screen.dart)): Wizard collection form for user age, weight, and height.
* **Dashboard Logger** ([nutrition_dashboard_screen.dart](file:///g:/Tio/apps/mobile/lib/src/features/nutrition/presentation/screen/nutrition_dashboard_screen.dart)): Dynamic text area supporting conversational logging (e.g. *"I had a banana and protein shake"*).
* **Logs History** ([logs_history_screen.dart](file:///g:/Tio/apps/mobile/lib/src/features/nutrition/presentation/screen/logs_history_screen.dart)): Pull-to-refresh timeline showing previous logs with calendar indicators.
* **App Router** ([app_router.dart](file:///g:/Tio/apps/mobile/lib/src/routing/app_router.dart)): Configured routing mapping welcome flow to auth, onboarding, and dashboard paths.

---

### 4. FastAPI Nutrition Service (`backend/nutrition-service`)
Implemented the **Meal Intelligence Engine** in Python/FastAPI:
* **Edamam API Client** ([edamam_service.py](file:///g:/Tio/backend/nutrition-service/services/edamam_service.py)): Queries food parse details and extracts standardized nutritional values (calories, macros).
* **FatSecret API Client** ([fatsecret_service.py](file:///g:/Tio/backend/nutrition-service/services/fatsecret_service.py)): OAuth2-authenticated food search endpoint.
* **Router Controllers** ([main.py](file:///g:/Tio/backend/nutrition-service/main.py)): Main entry point that parses the root environment files and exposes `/api/nutrition/parse` and `/api/nutrition/search`.

---

## 🏗️ Build & Compilation Status

* **Status**: **SUCCESSFUL**
* **Command run**:
  ```powershell
  $env:JAVA_HOME="C:\Program Files\Android\Android Studio\jbr"; npx.cmd turbo build
  ```
* **APK Output**: [apps/mobile/build/app/outputs/flutter-apk/app-release.apk](file:///g:/Tio/apps/mobile/build/app/outputs/flutter-apk/app-release.apk) compiles successfully.

---

## 🛠️ Next Steps

1. **Pnpm Store Relocation Cleanup**:
   * Delete legacy `G:\.pnpm-store` folder.
   * Run a fresh install to write all dependency caches directly to the new `G:\dev\.pnpm-store` workspace.
2. **Local Environment Run**:
   * Spin up local Supabase database instance (`supabase start`).
   * Start local FastAPI backend (`pnpm --filter nutrition-service dev`).
