def calculate_priority(*, urgency: float, importance: float, effort: float = 0.5, dependency: float = 0.0, progress: float = 0.0) -> int:
    """Return a deterministic 0-100 priority score."""
    score = (
        urgency * 40
        + importance * 25
        + effort * 10
        + dependency * 10
        + (1 - progress) * 10
        + 5 * 0.5
    )
    return max(0, min(100, round(score)))
