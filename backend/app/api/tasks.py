from fastapi import APIRouter
from pydantic import BaseModel
from app.services.priority_service import calculate_priority

router = APIRouter()
_TASKS: list[dict] = []

class TaskCreate(BaseModel):
    title: str
    description: str | None = None
    deadline: str | None = None
    priority: str = 'medium'
    estimated_minutes: int = 30
    category: str = 'general'
    source: str = 'manual'
    importance: int = 50
    progress: int = 0
    dependency_count: int = 0

@router.get('/')
def list_tasks():
    return {'tasks': _TASKS}

@router.post('/')
def create_task(payload: TaskCreate):
    priority = calculate_priority(deadline=payload.deadline, importance=payload.importance, estimated_minutes=payload.estimated_minutes, progress=payload.progress, dependency_count=payload.dependency_count)
    task = payload.model_dump()
    task.update({'id': str(len(_TASKS) + 1), 'priority_score': priority['score'], 'priority_label': priority['label'], 'priority_reason': priority['reason'], 'status': 'pending'})
    _TASKS.append(task)
    return {'task': task}

@router.post('/score')
def score_task(payload: TaskCreate):
    return calculate_priority(deadline=payload.deadline, importance=payload.importance, estimated_minutes=payload.estimated_minutes, progress=payload.progress, dependency_count=payload.dependency_count)
