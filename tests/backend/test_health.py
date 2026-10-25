from fastapi.testclient import TestClient

from app.main import app

client = TestClient(app)


def test_health_endpoint():
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json() == {"status": "ok", "service": "actify-api"}


def test_create_list_update_and_delete_task():
    created = client.post(
        "/api/tasks/",
        json={"title": "Finish assignment", "importance": 90, "estimated_minutes": 45},
    )
    assert created.status_code == 201
    task = created.json()["task"]
    assert task["title"] == "Finish assignment"
    assert 0 <= task["priority_score"] <= 100
    assert task["priority_label"] in {"low", "medium", "high"}

    task_id = task["id"]
    assert any(item["id"] == task_id for item in client.get("/api/tasks/").json()["tasks"])

    updated = client.patch(f"/api/tasks/{task_id}/status", params={"status": "completed"})
    assert updated.status_code == 200
    assert updated.json()["task"]["status"] == "completed"

    deleted = client.delete(f"/api/tasks/{task_id}")
    assert deleted.status_code == 204
    assert client.delete(f"/api/tasks/{task_id}").status_code == 404


def test_blank_title_is_rejected():
    response = client.post("/api/tasks/", json={"title": "   "})
    assert response.status_code == 422


def test_invalid_deadline_is_rejected():
    response = client.post("/api/tasks/", json={"title": "Something", "deadline": "next friday"})
    assert response.status_code == 422


def test_schedule_returns_next_best_action():
    client.post("/api/tasks/", json={"title": "Urgent task", "estimated_minutes": 15, "importance": 100})
    response = client.get("/api/schedule/", params={"available_minutes": 60})
    assert response.status_code == 200
    payload = response.json()
    assert payload["schedule"]
    assert payload["next_best_action"]["title"] == "Urgent task"
