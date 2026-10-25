from datetime import datetime, timezone

from fastapi import APIRouter, Query

from app.api.tasks import _TASKS
from app.services.scheduling_service import schedule_tasks

router = APIRouter()


@router.get("/")
def get_schedule(
    available_minutes: int = Query(default=240, ge=0, le=1440),
    start: datetime | None = None,
):
    start_time = start or datetime.now(timezone.utc)
    eligible = [task for task in _TASKS if task.get("status") != "completed"]
    plan = schedule_tasks(eligible, start_time, available_minutes)
    next_action = plan[0] if plan else None
    return {"schedule": plan, "next_best_action": next_action, "available_minutes": available_minutes}
