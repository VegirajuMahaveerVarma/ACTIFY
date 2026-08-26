# ACTIFY

**AI-Powered Action Intelligence Platform**

> Turn Information into Action.

ACTIFY is a phone-first AI productivity application that converts scattered information—camera captures, voice, screenshots, text, and documents—into prioritized tasks, practical schedules, and a clear **Next Best Action**.

## Core Loop

**CAPTURE → UNDERSTAND → PRIORITIZE → PLAN → ACT → ADAPT**

## Repository Structure

```text
ACTIFY/
├── mobile/       # Flutter mobile application
├── backend/      # FastAPI backend and application intelligence
├── ai/           # Prompt and structured-output definitions
├── database/     # Supabase/PostgreSQL schema and migrations
├── docs/         # Architecture, API and demo documentation
└── tests/        # Mobile, backend and AI tests
```

## MVP Focus

1. Camera-to-Action
2. Voice-to-Action
3. Screenshot/Text-to-Action
4. AI task and deadline extraction
5. Intelligent priority scoring
6. Scheduling
7. Next Best Action
8. Dynamic replanning
9. AI Assistant

## Technology

- Flutter + Dart
- Gemini API
- Google ML Kit / OCR
- Android Speech Recognition
- Python + FastAPI
- Supabase PostgreSQL + Auth + Storage
- Firebase Cloud Messaging

## Architecture Principle

Gemini is responsible for language understanding and structured extraction. Deterministic application logic handles priority scoring, scheduling, conflict detection, task state, and replanning.

## Team

**Quantum Coders**

