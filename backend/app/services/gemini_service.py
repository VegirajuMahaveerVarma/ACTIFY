import json
import os

from app.core.config import settings


def extract_task(text: str) -> dict:
    """Extract a normalized task from natural language.

    The real Gemini call will be added here. Keeping the output contract stable
    lets the mobile app and deterministic intelligence engines develop in parallel.
    """
    return {
        'title': text.strip()[:120],
        'description': text.strip(),
        'deadline': None,
        'priority': 'medium',
        'estimated_minutes': 30,
        'category': 'general',
        'source': 'text',
        'confidence': 0.0,
        'provider': 'gemini' if settings.gemini_api_key else 'stub',
    }
