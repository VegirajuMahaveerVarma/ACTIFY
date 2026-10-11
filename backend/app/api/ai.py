from fastapi import APIRouter
from pydantic import BaseModel, Field, field_validator

from app.services.gemini_service import extract_task

router = APIRouter()


class ExtractTaskRequest(BaseModel):
    input: str = Field(min_length=1, max_length=12000)

    @field_validator("input")
    @classmethod
    def input_must_not_be_blank(cls, value: str) -> str:
        value = value.strip()
        if not value:
            raise ValueError("input must not be blank")
        return value


@router.post("/extract-task")
def extract_task_endpoint(payload: ExtractTaskRequest):
    return extract_task(payload.input)
