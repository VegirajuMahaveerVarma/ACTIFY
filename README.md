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

ACTIFY is built around one loop: **CAPTURE → UNDERSTAND → PRIORITIZE → PLAN → ACT → ADAPT**. The current MVP foundation includes AI task extraction with a no-key fallback, validated task APIs, deterministic priority scoring, and a schedule endpoint that returns a Next Best Action.

> **Status:** early MVP development. Persistent storage, authentication, and production device-capture flows are not yet complete.

## Product principles

- **Action over chat:** surface a next step rather than endless conversation.
- **Explainable priorities:** combine deadline urgency, importance, progress, effort, and dependencies with deterministic application logic.
- **Honest states:** external AI and capture features have clear fallbacks; UI placeholders are not presented as completed integrations.
- **Cyber aesthetic, focused UX:** near-black surfaces, cyan highlights, electric-blue details, and restrained violet accents.

## Architecture

```text
ACTIFY/
├── mobile/       # Flutter app and cyber-inspired design system
├── backend/      # FastAPI service and action-planning logic
├── ai/           # Prompt and structured-output definitions
├── database/     # SQL schema; persistence integration pending
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

Activate the environment and install dependencies:

```powershell
.venv\Scripts\Activate.ps1
pip install -r requirements.txt
uvicorn app.main:app --reload
```

On macOS/Linux, use `source .venv/bin/activate` instead.

The health endpoint is available at `http://127.0.0.1:8000/health`. Interactive API docs are at `http://127.0.0.1:8000/docs`.

Copy `backend/.env.example` to `backend/.env` and fill in your own credentials if required. Never commit real keys.

### Mobile app

In a second terminal:

```bash
cd mobile
flutter pub get
flutter analyze
flutter test
flutter run
```

To point the app at the backend, pass `--dart-define=ACTIFY_API_URL=http://10.0.2.2:8000` for a standard Android emulator. A physical device needs your computer's reachable LAN IP. Configure the URL for your actual target.

## API overview

| Method | Endpoint | Purpose |
| --- | --- | --- |
| GET | `/health` | Service health |
| GET | `/api/tasks/` | List tasks |
| POST | `/api/tasks/` | Create a validated and scored task |
| POST | `/api/tasks/score` | Score a task without storing it |
| PATCH | `/api/tasks/{task_id}/status?status=in_progress` | Update task status |
| DELETE | `/api/tasks/{task_id}` | Delete a task |
| GET | `/api/schedule/?available_minutes=240` | Build a plan and return the Next Best Action |
| POST | `/api/ai/extract-task` | Convert text into structured task data |

## Quality checks

Run backend and AI tests from the repository root:

```bash
python -m pip install -r backend/requirements.txt pytest
python -m pytest tests/backend tests/ai
```

GitHub Actions also runs Flutter static analysis and tests. A passing workflow is a useful baseline, not proof of production readiness across every device and integration.

## Roadmap

- [x] Add task APIs and a basic action-planning loop.
- [x] Add deterministic priority scoring and backend regression tests.
- [x] Connect the text-capture screen to AI task extraction.
- [ ] Connect durable storage and verify sync behavior.
- [ ] Implement camera, OCR, screenshot import, and voice capture end-to-end.
- [ ] Implement and review authentication and production security boundaries.
- [ ] Add real-device screenshots, accessibility checks, and deployment documentation.

## Contributing

Issues and focused pull requests are welcome. Please include the problem being solved, reproduction steps where relevant, and the checks you ran.

## Team

**Quantum Coders**
