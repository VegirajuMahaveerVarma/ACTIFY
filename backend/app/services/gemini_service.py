import json
import os
from typing import Any

from app.core.config import settings


def _fallback(text: str) -> dict[str, Any]:
    value = text.strip()
    return {
        'title': value[:120] or 'New task',
        'description': value,
        'deadline': None,
        'priority': 'medium',
        'estimated_minutes': 30,
        'category': 'general',
        'source': 'text',
        'confidence': 0.35,
        'provider': 'stub',
    }


def extract_task(text: str) -> dict[str, Any]:
    if not settings.gemini_api_key:
        return _fallback(text)
    try:
        from google import genai
        client = genai.Client(api_key=settings.gemini_api_key)
        prompt = f'''You are ACTIFY, an action-intelligence assistant.
Convert the user's input into ONE actionable task.
Return ONLY valid JSON with these keys: title, description, deadline, priority, estimated_minutes, category, source, confidence.
priority must be low, medium, or high. estimated_minutes must be an integer. deadline must be ISO-8601 when clearly present, otherwise null. Do not invent a deadline. confidence must be between 0 and 1.

User input:
{text}'''
        response = client.models.generate_content(
            model=os.getenv('GEMINI_MODEL', 'gemini-2.5-flash'),
            contents=prompt,
        )
        raw = response.text.strip()
        if raw.startswith('```'):
            raw = raw.replace('```json', '', 1).replace('```', '', 1).strip()
        result = json.loads(raw)
        result['source'] = result.get('source') or 'text'
        result['provider'] = 'gemini'
        return result
    except Exception:
        return _fallback(text)
