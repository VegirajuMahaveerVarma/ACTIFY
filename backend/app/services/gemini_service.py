from typing import Any

from app.core.config import settings


def _fallback(text: str) -> dict[str, Any]:
    value = text.strip()
    return {
        "title": value[:120] or "New task",
        "description": value,
        "deadline": None,
        "priority": "medium",
        "estimated_minutes": 30,
        "category": "general",
        "source": "text",
        "confidence": 0.35,
        "provider": "stub",
    }


def extract_task(text: str) -> dict[str, Any]:
    value = text.strip()
    if not value:
        return _fallback("")

    if not settings.gemini_api_key:
        return _fallback(value)

    try:
        import json

        from google import genai

        client = genai.Client(api_key=settings.gemini_api_key)
        prompt = f"""You are ACTIFY, an action-intelligence assistant.
Convert the user's input into ONE actionable task.
Return ONLY valid JSON with these keys: title, description, deadline, priority, estimated_minutes, category, source, confidence.
priority must be low, medium, or high. estimated_minutes must be an integer from 1 to 1440.
deadline must be ISO-8601 when clearly present, otherwise null. Do not invent a deadline.
confidence must be between 0 and 1.

User input:
{value}"""
        response = client.models.generate_content(
            model=settings.gemini_model,
            contents=prompt,
        )
        raw = (response.text or "").strip()
        if raw.startswith("```"):
            raw = raw.removeprefix("```json").removeprefix("```").strip()
            if raw.endswith("```"):
                raw = raw[:-3].strip()
        result = json.loads(raw)
        title = str(result.get("title") or "").strip()
        if not title:
            return _fallback(value)

        priority = str(result.get("priority", "medium")).lower()
        if priority not in {"low", "medium", "high"}:
            priority = "medium"

        try:
            estimate = int(result.get("estimated_minutes", 30))
        except (TypeError, ValueError):
            estimate = 30

        try:
            confidence = float(result.get("confidence", 0.5))
        except (TypeError, ValueError):
            confidence = 0.5

        result.update(
            {
                "title": title[:160],
                "description": str(result.get("description") or value)[:4000],
                "deadline": result.get("deadline"),
                "priority": priority,
                "estimated_minutes": max(1, min(1440, estimate)),
                "category": str(result.get("category") or "general")[:80],
                "source": "text",
                "confidence": max(0.0, min(1.0, confidence)),
                "provider": "gemini",
            }
        )
        return result
    except Exception:
        return _fallback(value)
