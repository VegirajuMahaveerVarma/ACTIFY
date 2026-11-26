# ACTIFY — Focus Into Action

<p align="center">
  <img src="https://img.shields.io/badge/ACTIFY-FOCUS%20INTO%20ACTION-D6F36A?style=for-the-badge&labelColor=0E0F11" alt="ACTIFY — Focus Into Action">
</p>

<p align="center">
  <strong>Turn scattered information into clear, actionable work.</strong><br>
  An AI-assisted, mobile-first productivity system designed to capture context, organize tasks, and help people decide what to do next.
</p>

<p align="center">
  <a href="https://github.com/VegirajuMahaveerVarma/ACTIFY/actions/workflows/ci.yml"><img src="https://github.com/VegirajuMahaveerVarma/ACTIFY/actions/workflows/ci.yml/badge.svg" alt="CI"></a>
  <img src="https://img.shields.io/badge/Client-Flutter-02569B?logo=flutter&logoColor=white" alt="Flutter">
  <img src="https://img.shields.io/badge/Backend-FastAPI-009688?logo=fastapi&logoColor=white" alt="FastAPI">
  <img src="https://img.shields.io/badge/Language-Python%20%7C%20Dart-3776AB?logo=python&logoColor=white" alt="Python and Dart">
  <img src="https://img.shields.io/badge/Stage-Early%20Development-D6F36A?labelColor=17191C" alt="Early development">
</p>

---

## What is ACTIFY?

Important tasks are often buried inside screenshots, messages, documents, voice notes, and passing thoughts. ACTIFY is being developed to bring those inputs into one place and turn useful information into structured tasks.

The goal is simple: **spend less time organizing information and more time taking meaningful action.**

ACTIFY explores an AI-assisted workflow that can identify task details and context, while predictable application logic handles prioritization, scheduling constraints, and task-state changes.

> **Project status:** ACTIFY is in early development. This repository contains an initial Flutter client, a FastAPI service, AI prompt/schema definitions, a database schema, and initial tests. Roadmap items below are planned ideas—not claims of completed functionality.

## The workflow

```text
  CAPTURE
     |
     v
  UNDERSTAND  --->  REVIEW & CORRECT
     |                    |
     v                    v
  ORGANIZE  ------->  PRIORITIZE
                         |
                         v
                      SCHEDULE
                         |
                         v
                  NEXT BEST ACTION
                         |
                         v
                      EXECUTE
                         |
                         v
                  UPDATE & REPLAN
```

| Stage | Purpose |
| --- | --- |
| Capture | Bring supported information sources into a single intake flow. |
| Understand | Extract possible tasks, dates, entities, and useful context. |
| Review | Let the user verify and correct extracted information. |
| Organize | Structure tasks and connect related work. |
| Prioritize | Apply transparent, repeatable task-priority rules. |
| Schedule | Suggest an execution order around time and deadline constraints. |
| Execute | Highlight a useful next action. |
| Update | Reflect progress and revise plans when circumstances change. |

## Product direction

### 1. Intelligent capture
- Screenshot, image, document, and copied-text intake.
- Voice notes and speech-to-text task capture.
- OCR and document text extraction.
- Context extraction for task descriptions, dates, and entities.
- Duplicate and near-duplicate detection.
- Review extracted details before saving.

### 2. Task and time intelligence
- Explainable priority scoring based on urgency, importance, effort, and deadlines.
- A **Next Best Action** recommendation.
- Smart scheduling with duration and availability constraints.
- Reminders, recurring tasks, subtasks, and dependencies.
- Project, tag, and focused task views.
- Automatic replanning when priorities or plans change.
- Progress summaries and workload insights.

### 3. Personal productivity foundations
- Offline-first access to core task information.
- Reliable synchronization and conflict handling.
- Secure accounts and user-scoped data.
- Privacy controls, data export, and deletion.
- Calendar integration exploration.
- Configurable AI-provider integrations.
- Accessible, responsive mobile interactions.

### 4. Engineering and reliability
- Structured AI output validation and recovery.
- Evaluation examples for image, voice, and document extraction.
- End-to-end tests for core workflows.
- Useful diagnostics that avoid exposing private content.
- Performance and resilience testing.
- Deployment, migration, and backup documentation.

## Architecture at a glance

```text
ACTIFY
├── mobile/       Flutter client and interaction layer
├── backend/      FastAPI service layer
├── ai/           Prompt contracts and output schemas
├── database/     Relational database schema
├── docs/         Project and technical documentation
└── tests/        Backend and AI contract tests
```

The intended separation of responsibilities is:

- **Mobile client:** presentation, capture, and user interaction.
- **Backend:** API boundary and application services.
- **AI layer:** interpretation of unstructured information.
- **Database:** persistence structures for application data.
- **Tests:** checks for implemented behavior and cross-layer contracts.

### Technology stack

| Area | Technology represented in this repository |
| --- | --- |
| Mobile | Flutter, Dart, Provider |
| Input | HTTP, image picker, speech-to-text |
| Backend | Python, FastAPI, Pydantic |
| AI integration | Gemini SDK, prompt and schema definitions |
| Data | Supabase client, PostgreSQL-oriented schema |
| Testing | pytest, Flutter analyzer, Flutter tests |
| Automation | GitHub Actions |

## Getting started

### Prerequisites

Install the tools required for the parts you want to run:

- Python and pip
- Flutter SDK and Dart
- Git

### 1. Clone the repository

```bash
git clone https://github.com/VegirajuMahaveerVarma/ACTIFY.git
cd ACTIFY
```

### 2. Run the backend

Create and activate a virtual environment:

```bash
cd backend
python -m venv .venv
```

Windows PowerShell:

```powershell
.venv\Scripts\Activate.ps1
```

macOS / Linux:

```bash
source .venv/bin/activate
```

Install dependencies and start the API:

```bash
pip install -r requirements.txt
uvicorn app.main:app --reload
```

When the service starts successfully:

- Health endpoint: http://127.0.0.1:8000/health
- Interactive API documentation: http://127.0.0.1:8000/docs

If integrations require environment variables, copy `backend/.env.example` to `backend/.env` and add the required values.

### 3. Run the mobile app

Open another terminal:

```bash
cd mobile
flutter pub get
flutter analyze
flutter test
flutter run
```

Make sure the app's backend base URL points to an address reachable from the device. For a standard Android emulator, the host machine is commonly reachable at `10.0.2.2`; a physical device needs a reachable network address.

### 4. Run backend tests

From the repository root:

```bash
python -m pip install -r backend/requirements.txt pytest
python -m pytest tests/backend tests/ai
```

## Roadmap

The checklist is a forward-looking plan. Items should be checked off only after implementation and verification.

- [ ] Unified capture inbox for text, images, voice, and documents
- [ ] OCR and document parsing with source references
- [ ] Editable AI-extracted task drafts
- [ ] Duplicate detection across capture sources
- [ ] Explainable priority scoring
- [ ] Next Best Action recommendations
- [ ] Constraint-aware scheduling and replanning
- [ ] Reminders, recurring tasks, subtasks, and dependencies
- [ ] Projects, tags, search, and task filters
- [ ] Offline task access and robust synchronization
- [ ] Authentication and user-level data isolation
- [ ] Privacy controls, export, and deletion
- [ ] Calendar connectivity
- [ ] AI extraction evaluation suite
- [ ] End-to-end workflow and failure-recovery tests
- [ ] Deployment, migration, and backup guides

## Design principles

1. **Human-in-the-loop:** AI suggestions should be reviewable and correctable.
2. **Explainable decisions:** users should understand why a task is prioritized.
3. **Deterministic execution rules:** repeatable operations should be governed by application logic, not left entirely to model output.
4. **Privacy by design:** avoid exposing credentials and unnecessary personal content.
5. **Useful over noisy:** the interface should emphasize relevant information and the next practical action.

## Contributing

Contributions, suggestions, and constructive feedback are welcome.

1. Check existing issues before starting significant work.
2. Create a focused branch for your change.
3. Keep changes scoped to a clear problem or feature.
4. Add or update tests when behavior changes.
5. Update documentation when setup steps or interfaces change.
6. Open a pull request with a concise explanation and verification details.

For larger changes, open an issue first so the approach can be discussed.

## Security

- Never commit API keys, access tokens, passwords, or private configuration.
- Keep local environment files out of version control.
- Report suspected security issues privately to the repository owner rather than publishing sensitive details in an issue.

## Project identity

**Built by Quantum Coders**

---

<p align="center">
  <strong>ACTIFY — Capture less chaos. Create more momentum.</strong>
</p>
