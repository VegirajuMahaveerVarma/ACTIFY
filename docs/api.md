# ACTIFY Action Intelligence MVP

This branch adds a first practical backend loop for ACTIFY: create tasks, compute explainable priorities, update task status, and generate a simple time-bounded plan.

## Task API

- `GET /api/tasks/` lists in-memory tasks.
- `POST /api/tasks/` creates a validated task and returns its priority score, label, reason, ID, and creation time.
- `POST /api/tasks/score` calculates a priority without storing the task.
- `PATCH /api/tasks/{task_id}/status?status=pending|in_progress|completed` updates the task status.
- `DELETE /api/tasks/{task_id}` removes a task.

## Schedule API

- `GET /api/schedule/?available_minutes=240` builds a schedule for the time window and returns the first item as `next_best_action`.
- An optional ISO-8601 `start` query parameter can set the planning start time.

## Configuration

The backend loads `backend/.env` values through python-dotenv. Copy `backend/.env.example` to `backend/.env`. AI extraction falls back to a local deterministic response if the Gemini key is missing or the provider request fails.

## Current limitations

Task storage is in-memory and resets when the backend restarts. This branch does not yet wire Supabase persistence, production authentication, OCR, or real camera/audio intake. Do not treat the placeholder security module as an implemented security boundary.
