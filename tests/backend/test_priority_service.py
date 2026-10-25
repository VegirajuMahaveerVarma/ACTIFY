from app.services.priority_service import calculate_priority


def test_priority_score_is_bounded_and_explainable():
    result = calculate_priority(
        deadline="2026-10-25T12:00:00+00:00",
        importance=95,
        estimated_minutes=60,
        progress=0,
        dependency_count=2,
    )
    assert 0 <= result["score"] <= 100
    assert result["label"] in {"low", "medium", "high"}
    assert result["reason"]


def test_missing_deadline_has_fallback_urgency():
    result = calculate_priority(deadline=None, importance=30, estimated_minutes=15)
    assert result["score"] >= 0
    assert result["label"] in {"low", "medium", "high"}
