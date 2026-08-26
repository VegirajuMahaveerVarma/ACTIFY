# ACTIFY API

## Health

`GET /health`

## AI task extraction

`POST /api/ai/extract-task`

Request:

```json
{
  "input": "Complete the DAA assignment by Friday"
}
```

## Tasks

`GET /api/tasks/`

## Schedule

`GET /api/schedule/`

The API contract will grow as persistence, authentication and scheduling are implemented.
