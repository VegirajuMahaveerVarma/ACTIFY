from fastapi import APIRouter

router = APIRouter()


@router.get('/')
def get_schedule():
    return {'schedule': [], 'next_best_action': None}
