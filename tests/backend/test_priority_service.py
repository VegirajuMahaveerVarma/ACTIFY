try:
    from backend.app.services.priority_service import calculate_priority
except ModuleNotFoundError:
    from app.services.priority_service import calculate_priority


def test_priority_score_is_bounded():
    assert 0 <= calculate_priority(
        urgency=0.0,
        importance=0.0,
        effort=0.0,
        dependency=0.0,
        progress=1.0,
    ) <= 100
    assert 0 <= calculate_priority(
        urgency=1.0,
        importance=1.0,
        effort=1.0,
        dependency=1.0,
        progress=0.0,
    ) <= 100


def test_urgent_important_task_scores_higher():
    routine = calculate_priority(
        urgency=0.1,
        importance=0.2,
        effort=0.2,
        dependency=0.0,
        progress=0.0,
    )
    urgent = calculate_priority(
        urgency=1.0,
        importance=0.9,
        effort=0.5,
        dependency=0.4,
        progress=0.0,
    )
    assert urgent > routine


def test_progress_reduces_remaining_priority():
    early = calculate_priority(
        urgency=0.5,
        importance=0.7,
        effort=0.4,
        dependency=0.2,
        progress=0.0,
    )
    nearly_done = calculate_priority(
        urgency=0.5,
        importance=0.7,
        effort=0.4,
        dependency=0.2,
        progress=0.9,
    )
    assert early > nearly_done
