from datetime import datetime, timezone


def _deadline_urgency(deadline: str | None) -> float:
    if not deadline:
        return 0.35
    try:
        parsed = datetime.fromisoformat(deadline.replace("Z", "+00:00"))
        if parsed.tzinfo is None:
            parsed = parsed.replace(tzinfo=timezone.utc)
        hours_left = (parsed - datetime.now(timezone.utc)).total_seconds() / 3600
    except (TypeError, ValueError):
        return 0.35
    if hours_left <= 0:
        return 1.0
    if hours_left <= 6:
        return 0.95
    if hours_left <= 24:
        return 0.8
    if hours_left <= 72:
        return 0.65
    if hours_left <= 168:
        return 0.5
    return 0.25


def calculate_priority(
    *,
    deadline: str | None = None,
    importance: int = 50,
    estimated_minutes: int = 30,
    progress: int = 0,
    dependency_count: int = 0,
) -> dict[str, object]:
    """Calculate an explainable priority score from validated task details."""
    importance_value = max(0, min(100, importance)) / 100
    progress_value = max(0, min(100, progress)) / 100
    effort_value = min(max(estimated_minutes, 0) / 240, 1)
    dependency_value = min(max(dependency_count, 0) / 5, 1)
    urgency_value = _deadline_urgency(deadline)

    score = round(
        urgency_value * 40
        + importance_value * 25
        + effort_value * 10
        + dependency_value * 10
        + (1 - progress_value) * 10
        + 2.5
    )
    score = max(0, min(100, score))
    label = "high" if score >= 70 else "medium" if score >= 40 else "low"
    reasons = []
    if deadline:
        reasons.append("deadline urgency")
    if importance >= 70:
        reasons.append("high importance")
    if dependency_count:
        reasons.append("blocks other work")
    if progress >= 80:
        reasons.append("nearly complete")
    return {
        "score": score,
        "label": label,
        "reason": ", ".join(reasons) if reasons else "balanced urgency and importance",
    }
