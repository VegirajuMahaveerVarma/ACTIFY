# ACTIFY

<p align="center">
  <img src="https://img.shields.io/badge/ACTIFY-FOCUS%20INTO%20ACTION-D6F36A?style=for-the-badge&labelColor=0E0F11" alt="ACTIFY">
</p>

<p align="center">
  <strong>A context-mediated execution layer for the transition from informational entropy to actionable state.</strong><br/>
  An AI-assisted, mobile-first system for consolidating heterogeneous inputs, deriving task-oriented representations, and supporting priority-aware execution.
</p>

<p align="center">
  <a href="https://github.com/VegirajuMahaveerVarma/ACTIFY/actions/workflows/ci.yml"><img alt="CI" src="https://github.com/VegirajuMahaveerVarma/ACTIFY/actions/workflows/ci.yml/badge.svg"></a>
  <img alt="Flutter" src="https://img.shields.io/badge/mobile-Flutter%20%2F%20Dart-9AA0A6?logo=flutter&logoColor=white&labelColor=17191C">
  <img alt="Backend" src="https://img.shields.io/badge/backend-FastAPI-9AA0A6?logo=fastapi&logoColor=white&labelColor=17191C">
  <img alt="Status" src="https://img.shields.io/badge/status-early%20development-D6F36A?labelColor=17191C">
</p>

## 0. System premise

ACTIFY explores the conversion of fragmented personal information into a normalized, execution-oriented representation. Its input domain may include screenshots, voice-derived text, documents, and message content; its intended output domain comprises structured tasks, temporal constraints, relative priorities, schedule candidates, and a context-dependent **Next Best Action**.

The central problem is not merely information storage. It is the discontinuity between acquisition, interpretation, prioritization, and subsequent execution. ACTIFY is intended to reduce that discontinuity through a coordinated mobile/backend workflow in which extracted context can be transformed into actionable units.

> **Implementation boundary:** early development. The repository currently contains an initial Flutter application, a FastAPI service, AI prompt/schema definitions, and a database schema. The presence of a planned component or interface should not be interpreted as evidence of production completeness, operational guarantees, or validated end-to-end behavior.

## 1. Interaction philosophy

The interface adopts a low-noise visual grammar: dark tonal surfaces, controlled contrast, typographic hierarchy, and a restrained lime accent. The objective is to reduce visual competition while preserving sufficient affordance distinction for high-frequency task interactions.

The visual system is deliberately subordinate to the information hierarchy. Surface treatment, spacing, and emphasis are intended to communicate state and relevance rather than function as independent decoration.

## 2. Operational lifecycle

`INGEST → NORMALIZE → INTERPRET → PRIORITIZE → SCHEDULE → EXECUTE → RECONCILE`

| Phase | Intended responsibility |
| --- | --- |
| Ingest | Acquire information from supported user-facing input channels. |
| Normalize | Convert source-specific payloads into processable representations. |
| Interpret | Extract task candidates, entities, deadlines, and contextual signals. |
| Prioritize | Apply task attributes and application-level decision rules. |
| Schedule | Derive candidate execution sequences from available constraints. |
| Execute | Surface a contextually relevant next action to the user. |
| Reconcile | Incorporate task-state changes into subsequent planning cycles. |

This lifecycle is a conceptual model of the intended product behavior, not a claim that every phase is fully implemented.

## 3. Structural topology

```text
ACTIFY/
├── mobile/       # Flutter presentation and interaction surface
├── backend/      # FastAPI application boundary
├── ai/           # Prompt contracts and structured-output definitions
├── database/     # Relational persistence schema
├── docs/         # Architecture, API and demonstration material
└── tests/        # Initial backend and AI contract validation
```

The repository is organized around a client/service separation. The mobile layer owns presentation and user interaction; the backend exposes service capabilities; AI-related definitions describe interpretation contracts; and the database directory captures the current persistence model.

## 4. Technology substrate

| Concern | Current technology |
| --- | --- |
| Client runtime | Flutter, Dart, Provider |
| Input adapters | HTTP, image picker, speech-to-text |
| Service boundary | Python, FastAPI, Pydantic |
| Model integration | Gemini SDK and prompt/schema definitions |
| Persistence integration | Supabase client and PostgreSQL-oriented schema |
| Verification | pytest, Flutter analyzer and Flutter tests |

These entries describe the technologies represented in the repository, not necessarily fully integrated or production-hardened subsystems.

## 5. Local execution

### 5.1 Service initialization

From the repository root, create an isolated Python environment:

```bash
cd backend
python -m venv .venv
```

Activate the environment, install the declared dependencies, and start the ASGI application:

```powershell
# Windows PowerShell
.venv\Scripts\Activate.ps1
pip install -r requirements.txt
uvicorn app.main:app --reload
```

On macOS or Linux, activate the environment with `source .venv/bin/activate`.

The service health endpoint is available at `http://127.0.0.1:8000/health`; the interactive API schema is exposed at `http://127.0.0.1:8000/docs`.

Where external integrations are required, copy `backend/.env.example` to `backend/.env` and populate the corresponding configuration values. Credentials, tokens, and private keys must remain outside version control.

### 5.2 Client initialization

In a separate terminal:

```bash
cd mobile
flutter pub get
flutter analyze
flutter test
flutter run
```

The client must resolve a backend base URL reachable from its execution environment. Android emulators typically address the host machine through `10.0.2.2`; physical devices require a reachable LAN address and compatible network configuration.

## 6. Verification surface

The GitHub Actions workflow defines automated checks for backend tests and Flutter analysis/tests on pushes and pull requests. These checks provide a bounded verification signal; they do not establish cross-device correctness, external-provider availability, security certification, or production readiness.

Execute the current backend test paths from the repository root:

```bash
python -m pip install -r backend/requirements.txt pytest
python -m pytest tests/backend tests/ai
```

## 7. Decision-boundary principle

ACTIFY is intended to use model-assisted interpretation without delegating every consequential application decision to probabilistic output. Language-model functionality is positioned around semantic extraction and contextual understanding, while deterministic application logic is intended to govern repeatable operations such as priority scoring, scheduling constraints, conflict handling, task-state transitions, and replanning.

This separation establishes a design boundary between **interpretive inference** and **stateful execution policy**. It is a guiding architectural principle; the degree to which it is enforced should be evaluated against the implemented code and tests.

## 8. Forward work

- [ ] Evaluate extraction quality against representative screenshots, notes, and documents.
- [ ] Extend unit and API-contract coverage for task lifecycle and scheduling behavior.
- [ ] Implement and validate durable task persistence and synchronization semantics.
- [ ] Strengthen capture pipelines, including OCR behavior and malformed-input handling.
- [ ] Add setup documentation and screenshots from a verified application execution.
- [ ] Review configuration isolation, secret handling, and deployment prerequisites.

The roadmap records intended work. It should not be read as a feature-availability statement.

## 9. Contribution protocol

Issues and pull requests should identify the affected subsystem, describe the observed or proposed behavior, provide reproducible context where applicable, and enumerate the verification steps performed. Changes that affect cross-layer contracts should include corresponding updates to relevant tests or documentation.

## 10. Project identity

**Quantum Coders**
