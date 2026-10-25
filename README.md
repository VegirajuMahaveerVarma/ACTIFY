# ACTIFY

<p align="center">
  <img src="https://img.shields.io/badge/ACTIFY-CYBER%20INTELLIGENCE-35F2E2?style=for-the-badge&labelColor=070A12" alt="ACTIFY Cyber Intelligence">
</p>

<p align="center">
  <strong>Turn information into action.</strong><br/>
  A phone-first action-intelligence app designed to turn scattered notes and inputs into clear, prioritized next steps.
</p>

<p align="center">
  <a href="https://github.com/VegirajuMahaveerVarma/ACTIFY/actions/workflows/ci.yml"><img alt="CI" src="https://github.com/VegirajuMahaveerVarma/ACTIFY/actions/workflows/ci.yml/badge.svg"></a>
  <img alt="Flutter" src="https://img.shields.io/badge/mobile-Flutter%20%2F%20Dart-35F2E2?logo=flutter&logoColor=070A12&labelColor=101827">
  <img alt="Backend" src="https://img.shields.io/badge/backend-FastAPI-508CFF?logo=fastapi&logoColor=white&labelColor=101827">
  <img alt="Status" src="https://img.shields.io/badge/status-MVP%20development-9B7CFF?labelColor=101827">
</p>

ACTIFY is built around a simple loop: **CAPTURE → UNDERSTAND → PRIORITIZE → PLAN → ACT → ADAPT**. The current MVP foundation includes AI task extraction with a no-key fallback, validated task APIs, deterministic priority scoring, and a schedule endpoint that returns a Next Best Action.

> **Status:** early MVP development. Persistence, authentication, and production device capture flows are not yet complete.

## Product principles

- **Action over chat:** surface the next useful step, not endless conversation.
- **Explainable priorities:** use deterministic application logic to score urgency, importance, progress, effort, and dependencies.
- **Honest states:** external AI and capture features have clear fallbacks; UI placeholders are not presented as working integrations.
- **Cyber aesthetic, focused UX:** near-black surfaces, cyan highlights, electric-blue details, and restrained violet accents.

## Architecture

```text
ACTIFY/
├── mobile/       # Flutter mobile app and design system
├── backend/      # FastAPI endpoints and action logic
├── ai/           # Prompt and structured-output definitions
├── database/     # SQL schema (persistence integration pending)
├── docs/         # Architecture, API and demo notes
└── tests/        # Backend and AI contract tests
```

## Run locally

### Backend

From the repository root:

```bash
cd backend
python -m venv .venv
```

Activate the environment, install dependencies, and start the service:

```powershell
.venv\Scripts\Activate.ps1
pip install -r requirements.txt
uvicorn app.main:app --reload
```

On macOS/Linux, activate with `source .venv/bin/activate` instead.

The health endpoint is at `http://127.0.0.1:8000/health`; interactive API documentation is at `http://127.0.0.1:8000/docs`.

For local environment configuration:

```bash
cp .env.example .env
```

On Windows, copy `backend/.env.example` to `backend/.env` manually or use `Copy-Item .env.example .env` from inside the backend directory. Keep real credentials out of version control.

### Mobile app

In another terminal:

```bash
cd mobile
flutter pub get
flutter analyze
flutter test
flutter run
```

For Android emulators, the local computer is commonly reachable at `10.0.2.2`; a physical device needs the computer's LAN IP. Configure the app's API base URL for the device you are using.

## API overview

| Method | Endpoint | Purpose |
| --- | --- | --- |
| GET | `/health` | Service health |
| GET | `/api/tasks/` | List tasks |
| POST | `/api/tasks/` | Create and score a task |
| POST | `/api/tasks/score` | Score a task without storing it |
| PATCH | `/api/tasks/{task_id}/status` | Update task status |
| DELETE | `/api/tasks/{task_id}` | Delete a task |
| GET | `/api/schedule/?available_minutes=240` | Build a plan and return next best action |
| POST | `/api/ai/extract-task` | Convert input text to structured task data |

## Quality checks

Run backend and AI tests from the repository root:

```bash
python -m pip install -r backend/requirements.txt pytest
python -m pytest tests/backend tests/ai
```

The GitHub Actions workflow also runs Flutter analysis and tests. A passing workflow is a baseline, not proof of production readiness across all devices and integrations.

## Roadmap

- [x] Add validated task APIs and a basic action-planning loop.
- [x] Add deterministic priority scoring and tests.
- [ ] Connect task persistence and verify sync behavior.
- [ ] Implement camera, OCR, screenshot import, and voice capture end-to-end.
- [ ] Add authentication and review security boundaries before deployment.
- [ ] Add real-device screenshots, accessibility checks, and deployment documentation.

## Contributing

Issues and focused pull requests are welcome. Please include the problem being solved, reproduction steps where relevant, and the checks you ran.

## Team

**Quantum Coders**
