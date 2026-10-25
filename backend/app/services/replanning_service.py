from datetime import datetime, timezone

from app.services.scheduling_service import schedule_tasks


def replan(
    tasks: list[dict],
    *,
    start: datetime | None = None,
    available_minutes: int = 240,
) -> list[dict]:
    """Rebuild a plan from the current task state."""
    return schedule_tasks(
        tasks,
        start or datetime.now(timezone.utc),
        available_minutes,
    )
