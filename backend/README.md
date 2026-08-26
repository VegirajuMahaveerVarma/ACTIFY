# ACTIFY Backend

FastAPI service for AI understanding and deterministic application intelligence.

## Run

```bash
python -m venv .venv
# Windows
.venv\Scripts\activate
pip install -r requirements.txt
uvicorn app.main:app --reload
```

Copy `.env.example` to `.env` and add your credentials locally. Never commit real API keys.
