from fastapi import APIRouter
from pydantic import BaseModel

from app.services.gemini_service import extract_task

router = APIRouter()


class ExtractTaskRequest(BaseModel):
    input: str


@router.post('/extract-task')
def extract_task_endpoint(payload: ExtractTaskRequest):
    return extract_task(payload.input)
