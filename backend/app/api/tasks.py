from datetime import datetime, timezone

from fastapi import APIRouter, HTTPException
from pydantic import BaseModel, Field, field_validator

from app.services.priority_service import calculate_priority

router = APIRouter()
_TASKS: list[dict] = []


class TaskCreate(BaseModel):
    title: str = Field(min_length=1, max_length=160)
    description: str | None = Field(default=None, max_length=4000)
    deadline: str | None = None
    priority: str = Field(default="medium", pattern="^(low|medium|high)$")
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
        try:
            datetime.fromisoformat(value.strip().replace("Z", "+00:00"))
        except ValueError as exc:
            raise ValueError("deadline must be an ISO-8601 datetime") from exc
        return value.strip()


def _urgency_for_deadline(deadline: str | None) -> float:
    if not deadline:
        return 0.35
    due = datetime.fromisoformat(deadline.replace("Z", "+00:00"))
    now = datetime.now(timezone.utc)
    if due.tzinfo is None:
        due = due.replace(tzinfo=timezone.utc)
    hours_left = (due.astimezone(timezone.utc) - now).total_seconds() / 3600
    if hours_left <= 0:
        return 1.0
    if hours_left <= 24:
        return 0.95
    if hours_left <= 72:
        return 0.8
    if hours_left <= 168:
        return 0.6
    return 0.35


def _score_payload(payload: TaskCreate) -> dict:
    score = calculate_priority(
        urgency=_urgency_for_deadline(payload.deadline),
        importance=payload.importance / 100,
        effort=min(payload.estimated_minutes / 240, 1.0),
        dependency=min(payload.dependency_count / 5, 1.0),
        progress=payload.progress / 100,
    )
    label = "high" if score >= 70 else "medium" if score >= 45 else "low"
    reasons = []
    if payload.deadline:
        reasons.append("deadline proximity")
    if payload.importance >= 70:
        reasons.append("high importance")
    if payload.dependency_count:
        reasons.append("blocking dependencies")
    if payload.progress:
        reasons.append("progress already made")
    return {
        "score": score,
        "label": label,
        "reason": ", ".join(reasons) or "balanced default score",
    }


@router.get("/")
def list_tasks():
    return {"tasks": _TASKS}


@router.post("/")
def create_task(payload: TaskCreate):
    scoring = _score_payload(payload)
    task = payload.model_dump()
    task.update(
        {
            "id": str(len(_TASKS) + 1),
            "priority_score": scoring["score"],
            "priority_label": scoring["label"],
            "priority_reason": scoring["reason"],
            "status": "pending",
        }
    )
    _TASKS.append(task)
    return {"task": task}


@router.post("/score")
def score_task(payload: TaskCreate):
    return _score_payload(payload)


@router.patch("/{task_id}/status")
def update_task_status(task_id: str, status: str):
    if status not in {"pending", "in_progress", "completed"}:
        raise HTTPException(status_code=422, detail="Unsupported task status")
    task = next((item for item in _TASKS if item["id"] == task_id), None)
    if task is None:
        raise HTTPException(status_code=404, detail="Task not found")
    task["status"] = status
    return {"task": task}
