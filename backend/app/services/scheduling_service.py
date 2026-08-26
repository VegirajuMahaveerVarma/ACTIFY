from datetime import datetime, timedelta


def schedule_tasks(tasks: list[dict], start: datetime, available_minutes: int) -> list[dict]:
    """Simple sequential MVP scheduler; constraints will be expanded iteratively."""
    result = []
    cursor = start
    remaining = available_minutes

    for task in sorted(tasks, key=lambda item: item.get('priority_score', 0), reverse=True):
        duration = min(int(task.get('estimated_minutes', 30)), remaining)
        if duration <= 0:
            break
        end = cursor + timedelta(minutes=duration)
        result.append({**task, 'start': cursor.isoformat(), 'end': end.isoformat()})
        cursor = end
        remaining -= duration

    return result
