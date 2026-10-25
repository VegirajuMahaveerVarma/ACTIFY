from datetime import datetime
from uuid import uuid4

from fastapi import APIRouter, HTTPException, Response
from pydantic import BaseModel, Field, field_validator

from app.services.priority_service import calculate_priority

router = APIRouter()
_TASKS: list[dict] = []


class TaskCreate(BaseModel):
    title: str = Field(min_length=1, max_length=160)
    description: str | None = Field(default=None, max_length=4000)
    deadline: str | None = None
    priority: str = "medium"
    estimated_minutes: int = Field(default=30, ge=1, le=1440)
    category: str = Field(default="general", max_length=80)
    source: str = Field(default="manual", max_length=40)
    importance: int = Field(default=50, ge=0, le=100)
    progress: int = Field(default=0, ge=0, le=100)
    dependency_count: int = Field(default=0, ge=0, le=100)

    @field_validator("title")
    @classmethod
    def title_must_not_be_blank(cls, value: str) -> str:
        value = value.strip()
        if not value:
            raise ValueError("title must not be blank")
        return value

    @field_validator("deadline")
    @classmethod
    def deadline_must_be_iso8601(cls, value: str | None) -> str | None:
        if value is None or not value.strip():
            return None
        normalized = value.strip()
        try:
            datetime.fromisoformat(normalized.replace("Z", "+00:00"))
        except ValueError as exc:
            raise ValueError("deadline must be a valid ISO-8601 datetime") from exc
        return normalized


def _with_priority(payload: TaskCreate) -> dict:
    task = payload.model_dump()
    score = calculate_priority(
        deadline=payload.deadline,
        importance=payload.importance,
        estimated_minutes=payload.estimated_minutes,
        progress=payload.progress,
        dependency_count=payload.dependency_count,
    )
    task.update(
        {
            "id": str(uuid4()),
            "priority_score": score["score"],
            "priority_label": score["label"],
            "priority_reason": score["reason"],
            "status": "pending",
            "created_at": datetime.now().astimezone().isoformat(),
        }
    )
    return task


@router.get("/")
def list_tasks() -> dict[str, list[dict]]:
    return {"tasks": _TASKS}


@router.post("/", status_code=201)
def create_task(payload: TaskCreate) -> dict[str, dict]:
    task = _with_priority(payload)
    _TASKS.append(task)
    return {"task": task}


@router.post("/score")
def score_task(payload: TaskCreate) -> dict[str, object]:
    return calculate_priority(
        deadline=payload.deadline,
        importance=payload.importance,
        estimated_minutes=payload.estimated_minutes,
        progress=payload.progress,
        dependency_count=payload.dependency_count,
    )


@router.patch("/{task_id}/status")
def update_task_status(task_id: str, status: str) -> dict[str, dict]:
    allowed = {"pending", "in_progress", "completed"}
    if status not in allowed:
        raise HTTPException(status_code=422, detail=f"status must be one of: {', '.join(sorted(allowed))}")
    for task in _TASKS:
        if task["id"] == task_id:
            task["status"] = status
            return {"task": task}
    raise HTTPException(status_code=404, detail="Task not found")


@router.delete("/{task_id}", status_code=204)
def delete_task(task_id: str) -> Response:
    for index, task in enumerate(_TASKS):
        if task["id"] == task_id:
            _TASKS.pop(index)
            return Response(status_code=204)
    raise HTTPException(status_code=404, detail="Task not found")
