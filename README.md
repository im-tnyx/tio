# TIO (Tnyx) — Hybrid Health Monorepo

TIO is an AI-powered Adaptive Health Operating System. This repository is structured as a **Turborepo Monorepo** using a **Hybrid Architecture** designed to scale from a single nutrition logger to a full-fledged health platform.

## 🚀 Architecture Overview (Option 3)

We separate client interfaces, backend orchestrators, and AI/computation workloads to ensure high performance, code scalability, and cross-platform flexibility:

1. **Mobile Application ([apps/mobile](file:///g:/Tio/apps/mobile/README.md))**: Built using **Flutter (Dart)** for cross-platform iOS & Android clients.
2. **Web Application / Admin Portal (`apps/web`)**: Built using **Next.js (TypeScript)** for administrative dashboards and dietitian portals.
3. **Nutrition Service (`backend/nutrition-service`)**: Built using **FastAPI (Python)** to support macro/nutrition tracking, queries, and integrations (Edamam, FatSecret).
4. **Database & Auth Backend (`supabase`)**: Local and cloud Supabase setup for Row Level Security (RLS) PostgreSQL database management and user auth.

Detailed design diagrams and workflow specs can be found in [docs/ARCHITECTURE.md](file:///g:/Tio/docs/ARCHITECTURE.md).

---

## 📂 Active Project Structure

```text
tio-monorepo/
├── apps/
│   ├── mobile/                  # Flutter iOS/Android Application
│   └── web/                     # Next.js TypeScript Web Client (Dashboard)
│
├── backend/                     # Backend microservices
│   └── nutrition-service/       # FastAPI Python service (Nutrition & Meal Engine)
│
├── packages/                    # Shared TypeScript configurations
│   ├── typescript-config/
│   └── eslint-config/
│
├── supabase/                    # Local migrations and RLS schema configurations
│   ├── config.toml
│   └── migrations/
│
├── docs/                        # Real Project Planning & Architecture Documents
│   ├── ARCHITECTURE.md          # Complete Hybrid architecture reference
│   └── ROADMAP.md               # Detailed phase-wise milestone releases
│
├── package.json                 # Monorepo orchestration scripts
├── pnpm-workspace.yaml          # pnpm workspace configurations
└── turbo.json                   # Turborepo task piping rules
```

---

## 🎯 Phase 1 Release Scope: Nutrition Text Log

For **Phase 1 (MVP)**, the system is strictly focused on a **Profile Onboarding & Text Logging App** (no active AI recommendations or workout trackers in the first release):
- **Onboarding UI**: Collects age, height, weight, and user details.
- **Text Logs**: Captures raw unstructured food/health entries.
- **Database Storage**: Syncs directly to Supabase (`profiles` and `text_logs` tables).

Review the phase-by-phase feature checklists in [docs/ROADMAP.md](file:///g:/Tio/docs/ROADMAP.md).

---

## 🛠️ Local Execution & Commands

All tasks are centralized through Turborepo at the repository root:

* **Install dependencies**: `npx pnpm install`
* **Run dev servers**: `npx turbo dev`
* **Build all apps**: `npx turbo build`
* **Lint all apps**: `npx turbo lint`
* **Run mobile debug script**: Use the direct launcher [run_mobile_debug.bat](file:///g:/Tio/run_mobile_debug.bat).