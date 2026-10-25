# ACTIFY Action Intelligence MVP

This branch adds a first practical backend loop for ACTIFY: create tasks, calculate explainable priorities, update task status, and generate a simple time-bounded plan. The Flutter text capture screen can submit input to the task-extraction endpoint and display the structured response.

## Task API

- `GET /api/tasks/` lists tasks held in memory.
- `POST /api/tasks/` creates a validated task and returns its priority score, label, reason, ID, and creation time.
- `POST /api/tasks/score` calculates a priority without storing the task.
- `PATCH /api/tasks/{task_id}/status?status=pending|in_progress|completed` updates task status.
- `DELETE /api/tasks/{task_id}` removes a task.

## Schedule API

- `GET /api/schedule/?available_minutes=240` builds a plan within the selected time window and returns the first scheduled task as `next_best_action`.
- An optional ISO-8601 `start` query parameter sets the planning start time.

## AI task extraction

- `POST /api/ai/extract-task` accepts `{"input":"Finish assignment by Friday"}`.
- Configure `GEMINI_API_KEY` and optionally `GEMINI_MODEL` in `backend/.env`.
- When no key is configured or provider output cannot be parsed, the service returns a deterministic fallback response.

## Configuration

The backend reads local environment variables through python-dotenv. Copy `backend/.env.example` to `backend/.env` and keep all real secrets out of source control.

## Current limitations

Task storage is in-memory and resets when the service restarts. This branch does not yet wire Supabase persistence, production authentication, OCR, or real camera/audio intake. The placeholder security module is not an implemented security boundary.
