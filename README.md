# ACTIFY

<p align="center">
  <img src="https://img.shields.io/badge/ACTIFY-CYBER%20INTELLIGENCE-35F2E2?style=for-the-badge&labelColor=070A12" alt="ACTIFY Cyber Intelligence">
</p>

<p align="center">
  <strong>Turn information into action.</strong><br/>
  An AI-powered, phone-first action-intelligence project with a dark cyber-inspired interface.
</p>

<p align="center">
  <a href="https://github.com/VegirajuMahaveerVarma/ACTIFY/actions/workflows/ci.yml"><img alt="CI" src="https://github.com/VegirajuMahaveerVarma/ACTIFY/actions/workflows/ci.yml/badge.svg"></a>
  <img alt="Flutter" src="https://img.shields.io/badge/mobile-Flutter%20%2F%20Dart-35F2E2?logo=flutter&logoColor=070A12&labelColor=101827">
  <img alt="Backend" src="https://img.shields.io/badge/backend-FastAPI-508CFF?logo=fastapi&logoColor=white&labelColor=101827">
  <img alt="Status" src="https://img.shields.io/badge/status-early%20development-9B7CFF?labelColor=101827">
</p>

ACTIFY explores a simple idea: useful information is scattered across screenshots, voice notes, documents, and messages, while the next action is often unclear. The goal is to turn those inputs into structured tasks, sensible priorities, schedules, and a **Next Best Action**.

> **Project status:** early development. The repository contains a Flutter mobile foundation, a FastAPI service, AI prompt/schema definitions, and a database schema. Not every item in the product vision is implemented or production-ready yet.

## Visual direction

ACTIFY uses a cyber-inspired dark UI: near-black backgrounds, deep navy surfaces, neon cyan highlights, electric blue accents, and restrained violet details. The design aims to feel like a focused personal command center—not a cluttered sci-fi prop.

## Product loop

**CAPTURE → UNDERSTAND → PRIORITIZE → PLAN → ACT → ADAPT**

1. Capture information from supported inputs.
2. Extract task details into a predictable structure.
3. Apply deterministic rules for priority and deadlines.
4. Help the user decide what to do next.
5. Revisit the plan as tasks and deadlines change.

## Current repository layout

```text
ACTIFY/
├── mobile/       # Flutter app and cyber-inspired UI theme
├── backend/      # FastAPI service
├── ai/           # Prompt and structured-output definitions
├── database/     # SQL schema
├── docs/         # API, architecture and demo notes
└── tests/        # Initial backend and AI contract tests
```

## Technology

| Area | Technology |
| --- | --- |
| Mobile | Flutter, Dart, Provider |
| Input integrations | HTTP, image picker, speech-to-text |
| Backend | Python, FastAPI, Pydantic |
| AI integration | Gemini SDK and prompt/schema definitions |
| Data services | Supabase client and PostgreSQL-oriented schema |
| Quality checks | pytest, Flutter analyzer and Flutter tests |

## Run locally

### 1. Backend

From the repository root:

```bash
cd backend
python -m venv .venv
```

Activate the environment, then install dependencies and start the API:

```bash
# Windows PowerShell
.venv\Scripts\Activate.ps1

# macOS / Linux (use this instead on those systems)
source .venv/bin/activate

pip install -r requirements.txt
uvicorn app.main:app --reload
```

The API health endpoint is available at `http://127.0.0.1:8000/health`. Interactive API docs are at `http://127.0.0.1:8000/docs`.

Copy `backend/.env.example` to `backend/.env` and fill in credentials only when needed. Never commit real API keys or secrets.

### 2. Mobile app

In a second terminal, from the repository root:

```bash
cd mobile
flutter pub get
flutter analyze
flutter test
flutter run
```

If you run the app against a local backend, configure the API base URL for your target device. Android emulators typically reach the host machine through `10.0.2.2`; a physical device needs the computer's reachable LAN address. Do not assume `localhost` on a phone points to your development computer.

## Quality checks

The GitHub Actions workflow runs backend Python tests and Flutter static analysis/tests on pushes and pull requests. A green workflow is a useful baseline, not a claim that every device, external API, or production deployment has been validated.

Run the backend tests from the repository root:

```bash
python -m pip install -r backend/requirements.txt pytest
python -m pytest tests/backend tests/ai
```

## Design principle

Use AI for language understanding and extraction; use deterministic application logic for priority scoring, scheduling, conflict handling, task state, and replanning. This separation makes the behavior easier to test and explain.

## Roadmap

- [ ] Validate task extraction against realistic screenshots, notes, and documents.
- [ ] Add meaningful unit and API contract tests for task and schedule behavior.
- [ ] Implement durable task persistence and verify sync behavior.
- [ ] Complete capture flows, including OCR and input error states.
- [ ] Add setup instructions and screenshots from a verified app run.
- [ ] Validate secrets handling, API configuration, and deployment before describing the app as production-ready.

Roadmap items are intentions, not claims of completed functionality. The cyber styling is a UI layer; it does not indicate that ACTIFY is a cybersecurity product or that the app has undergone a security assessment.

## Contributing

Issues and focused pull requests are welcome. Please include the problem being solved, steps to reproduce it where relevant, and the checks you ran.

## Team

**Quantum Coders**
