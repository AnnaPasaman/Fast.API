# Змінюємо версію на 3.12, щоб вона відповідала вимогам pyproject.toml
FROM python:3.12-slim

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Оновлюємо pip та встановлюємо poetry найновішої версії
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir "poetry>=2.0.0"

# Вимикаємо створення віртуального оточення всередині контейнера
RUN poetry config virtualenvs.create false

# Копіюємо конфіг poetry
COPY pyproject.toml poetry.lock* ./

# Запускаємо встановлення залежностей
RUN poetry install --no-root --no-interaction --no-ansi

# Копіюємо весь інший код проекту
COPY . .

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000", "--reload", "--reload-dir", "/app"]