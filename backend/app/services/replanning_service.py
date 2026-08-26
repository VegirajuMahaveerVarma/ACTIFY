def replan(schedule: list[dict], conflicts: list[dict]) -> list[dict]:
    """MVP replanning hook. Conflict resolution rules will be added next."""
    if not conflicts:
        return schedule
    # Keep the interface deterministic while the scheduling engine evolves.
    return schedule
