# ACTIFY Architecture

## Core loop

CAPTURE → UNDERSTAND → PRIORITIZE → PLAN → ACT → ADAPT

## Components

- Flutter mobile app: phone-first capture and user experience.
- FastAPI: secure API boundary and orchestration.
- Gemini: language understanding and structured task extraction.
- Priority engine: deterministic priority scoring.
- Scheduling engine: deterministic time allocation.
- Replanning engine: conflict-aware schedule updates.
- Supabase: authentication, PostgreSQL data and storage.

## MVP vertical slice

Camera → OCR → FastAPI → Gemini → structured task → priority → schedule → Next Best Action.
