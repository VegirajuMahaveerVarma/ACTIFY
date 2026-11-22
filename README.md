# ACTIFY

<p align="center">
  <img src="https://img.shields.io/badge/ACTIFY-FOCUS%20INTO%20ACTION-D6F36A?style=for-the-badge&labelColor=0E0F11" alt="ACTIFY">
</p>

<p align="center">
  <strong>Turn everyday information into meaningful action.</strong><br/>
  An AI-powered, mobile-first productivity project designed to help people organize information, manage priorities, and take the next step with confidence.
</p>

<p align="center">
  <a href="https://github.com/VegirajuMahaveerVarma/ACTIFY/actions/workflows/ci.yml"><img alt="CI" src="https://github.com/VegirajuMahaveerVarma/ACTIFY/actions/workflows/ci.yml/badge.svg"></a>
  <img alt="Flutter" src="https://img.shields.io/badge/mobile-Flutter%20%2F%20Dart-9AA0A6?logo=flutter&logoColor=white&labelColor=17191C">
  <img alt="Backend" src="https://img.shields.io/badge/backend-FastAPI-9AA0A6?logo=fastapi&logoColor=white&labelColor=17191C">
  <img alt="Status" src="https://img.shields.io/badge/status-early%20development-D6F36A?labelColor=17191C">
</p>

ACTIFY is built around a common challenge: important information often gets lost across screenshots, voice notes, documents, and messages. Finding what matters and deciding what to do next can take more time than the task itself. ACTIFY aims to bring that information together and turn it into organized tasks, clear priorities, practical schedules, and a **Next Best Action**.

> **Project status:** early development. The repository includes the initial Flutter mobile application, a FastAPI backend, AI prompt and schema definitions, and a database schema. Some features are still being developed and have not yet been validated for production use.

## Design

ACTIFY follows a clean, minimalist visual style that keeps the experience focused. Its dark interface combines charcoal backgrounds, balanced contrast, readable typography, comfortable spacing, and a subtle lime accent. Every design choice aims to make information easier to scan and actions easier to identify.

## Product loop

**CAPTURE → UNDERSTAND → PRIORITIZE → PLAN → ACT → ADAPT**

1. Bring information together from supported input sources.
2. Identify important details and convert them into structured tasks.
3. Organize tasks using priorities, deadlines, and application rules.
4. Suggest a useful next action based on the available task information.
5. Update plans as priorities, deadlines, and task progress change.

## Repository layout

```text
ACTIFY/
├── mobile/       # Flutter app and minimalist UI theme
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

### Backend

From the repository root, create a Python virtual environment:

```bash
cd backend
python -m venv .venv
```

Activate the environment, install the required packages, and launch the API:

```powershell
# Windows PowerShell
.venv\Scripts\Activate.ps1
pip install -r requirements.txt
uvicorn app.main:app --reload
```

On macOS or Linux, activate the environment using `source .venv/bin/activate`.

Once the server is running, visit `http://127.0.0.1:8000/health` to check its status or open `http://127.0.0.1:8000/docs` to explore the API documentation.

Copy `backend/.env.example` to `backend/.env` and add the required credentials when needed. Keep private keys and secrets out of version control.

### Mobile app

Open a second terminal and run:

```bash
cd mobile
flutter pub get
flutter analyze
flutter test
flutter run
```

To connect the mobile app to a locally running backend, set the API base URL for your device. Android emulators generally use `10.0.2.2` to access the host machine, while physical devices need the computer's reachable local network address.

## Quality checks

The GitHub Actions workflow provides automated checks for backend tests and Flutter analysis and tests on pushes and pull requests. These checks help catch issues early, but do not replace testing across devices, external services, and production environments.

Run the backend test suite from the repository root:

```bash
python -m pip install -r backend/requirements.txt pytest
python -m pytest tests/backend tests/ai
```

## Design principle

ACTIFY aims to combine the strengths of AI with reliable application logic. AI is used to understand information and extract useful details, while predictable application rules handle priority scoring, scheduling, conflicts, task status, and replanning. This approach keeps decisions consistent, testable, and easier to understand.

## Roadmap

- [ ] Test task extraction using real-world screenshots, notes, and documents.
- [ ] Expand unit tests and API contract tests for task management and scheduling.
- [ ] Implement reliable task storage and validate synchronization.
- [ ] Improve information capture, including OCR and input error handling.
- [ ] Add setup guidance and screenshots from a verified application run.
- [ ] Review secret management, API configuration, and deployment readiness.

The current design represents the intended product experience; it does not mean every planned capability is already available.

## Contributing

Contributions, suggestions, and bug reports are welcome. When opening an issue or pull request, describe the proposed change, include reproduction steps when applicable, and mention the checks you performed.

## Team

**Quantum Coders**
