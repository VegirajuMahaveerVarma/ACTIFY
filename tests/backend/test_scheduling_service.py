from datetime import datetime, timezone

from app.services.scheduling_service import schedule_tasks


def test_schedule_respects_available_time_and_priority():
    tasks = [
        {"id": "a", "title": "Low", "priority_score": 20, "estimated_minutes": 30, "status": "pending"},
        {"id": "b", "title": "High", "priority_score": 80, "estimated_minutes": 20, "status": "pending"},
        {"id": "c", "title": "Completed", "priority_score": 100, "estimated_minutes": 5, "status": "completed"},
    ]
    plan = schedule_tasks(tasks, datetime(2026, 10, 25, tzinfo=timezone.utc), 30)
    assert [item["title"] for item in plan] == ["High"]
    assert plan[0]["end"] > plan[0]["start"]
