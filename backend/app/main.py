from fastapi import FastAPI

from app.api.ai import router as ai_router
from app.api.tasks import router as tasks_router
from app.api.schedule import router as schedule_router

app = FastAPI(title='ACTIFY API', version='0.1.0')

app.include_router(ai_router, prefix='/api/ai', tags=['AI'])
app.include_router(tasks_router, prefix='/api/tasks', tags=['Tasks'])
app.include_router(schedule_router, prefix='/api/schedule', tags=['Schedule'])


@app.get('/health')
def health() -> dict[str, str]:
    return {'status': 'ok', 'service': 'actify-api'}
