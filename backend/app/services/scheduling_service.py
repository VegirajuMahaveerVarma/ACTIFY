from datetime import datetime, timedelta, timezone


def schedule_tasks(
    tasks: list[dict],
    start: datetime,
    available_minutes: int,
) -> list[dict]:
    """Build a deterministic sequential plan inside the available time window."""
    if available_minutes < 0:
        raise ValueError("available_minutes must be non-negative")
    if start.tzinfo is None:
        start = start.replace(tzinfo=timezone.utc)

    cursor = start
    remaining = available_minutes
    result: list[dict] = []
    ordered = sorted(
        tasks,
        key=lambda item: (
            item.get("status") == "completed",
            -int(item.get("priority_score", 0)),
            item.get("deadline") or "9999",
        ),
    )
    for task in ordered:
        if task.get("status") == "completed":
            continue
        duration = max(1, int(task.get("estimated_minutes", 30)))
        if duration > remaining:
            continue
        end = cursor + timedelta(minutes=duration)
        result.append({**task, "start": cursor.isoformat(), "end": end.isoformat()})
        cursor = end
        remaining -= duration
    return result
