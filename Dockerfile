
FROM python:3.12-slim

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1


RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir "poetry>=2.0.0"


RUN poetry config virtualenvs.create false


COPY pyproject.toml poetry.lock* ./


RUN poetry install --no-root --no-interaction --no-ansi


COPY . .

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000", "--reload", "--reload-dir", "/app"]