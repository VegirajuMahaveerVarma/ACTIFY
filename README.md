# ACTIFY

**AI-Powered Action Intelligence Platform**

> Turn information into action.

ACTIFY is a phone-first productivity app designed to turn scattered information—voice, notes, screenshots, and documents—into clear tasks, priorities, and a practical next step.

## Core loop

**CAPTURE → UNDERSTAND → PRIORITIZE → PLAN → ACT → ADAPT**

## Repository structure

```text
ACTIFY/
├── mobile/       # Flutter mobile application
├── backend/      # FastAPI API and application intelligence
├── ai/           # Prompt and structured-output definitions
├── database/     # Supabase/PostgreSQL schema and migrations
├── docs/         # Architecture, API and demo documentation
└── tests/        # Backend and AI tests
```

## Current MVP status

- [x] Interactive task dashboard with open/completed counts
- [x] Next-action card and task completion
- [x] Manual task capture
- [x] Speech-to-text capture (device support and permissions required)
- [x] Camera capture with a manual description fallback
- [x] Deterministic backend priority scoring and task status updates
- [x] Optional Gemini task extraction endpoint
- [ ] OCR-based extraction from captured images
- [ ] Durable task storage and authenticated per-user sync
- [ ] Full calendar-aware scheduling and replanning

Tasks created in the current Flutter UI are session-only. Camera capture currently does not run OCR; the capture screen explains this and lets the user describe the image manually.

## Run locally

### Mobile

```bash
cd mobile
flutter create --platforms android . # only if mobile/android/ is missing
flutter pub get
flutter analyze
flutter test
flutter run
```

### Backend

```bash
cd backend
python -m venv .venv
# Activate the virtual environment, then:
pip install -r requirements.txt
uvicorn app.main:app --reload
```

The backend health check is available at `GET /health`. Interactive API documentation is available at `/docs`.

Set `GEMINI_API_KEY` in the backend environment to enable Gemini extraction; without a key, the extractor returns a clearly identified local fallback result.

## Technology

- Flutter + Dart
- Python + FastAPI + Pydantic
- Gemini API (optional)
- Supabase/PostgreSQL schema prepared for persistence
- Android speech recognition and image capture

## Architecture principle

AI is used for language understanding and structured extraction. Deterministic application logic owns priority scoring, task status, and scheduling decisions so those behaviors remain testable and predictable.

## Team

**Quantum Coders**
