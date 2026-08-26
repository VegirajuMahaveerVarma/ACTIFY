from dataclasses import dataclass


@dataclass(frozen=True)
class Settings:
    gemini_api_key: str = ''
    supabase_url: str = ''
    supabase_key: str = ''


settings = Settings()
