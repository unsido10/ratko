FROM python:3.10-slim AS python-base

# --- НАСТРОЙКИ ОКРУЖЕНИЯ ---
ENV DOCKER=true \
    GIT_PYTHON_REFRESH=quiet \
    PIP_NO_CACHE_DIR=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

# --- УСТАНОВКА СИСТЕМНЫХ ЗАВИСИМОСТЕЙ ---
RUN apt update && apt install -y --no-install-recommends \
    libcairo2 \
    git \
    build-essential \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# --- ПРАВИЛЬНАЯ УСТАНОВКА NODE.JS ---
# Раз твоим модулям нужен Node.js, ставим стабильную 18-ю версию без ошибок в синтаксисе
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/* /tmp/*

# --- РАБОЧЕЕ ПРОСТРАНСТВО ---
RUN mkdir -p /data/private /data/Heroku
WORKDIR /data/Heroku

# Копируем файлы твоего форка Ratko, которые Render уже успешно скачал из GitHub
FROM python:3.10-slim AS python-base

# --- НАСТРОЙКИ ОКРУЖЕНИЯ ---
ENV DOCKER=true \
    GIT_PYTHON_REFRESH=quiet \
    PIP_NO_CACHE_DIR=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

# --- УСТАНОВКА СИСТЕМНЫХ ЗАВИСИМОСТЕЙ ---
RUN apt update && apt install -y --no-install-recommends \
    libcairo2 \
    git \
    build-essential \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# --- ПРАВИЛЬНАЯ УСТАНОВКА NODE.JS ---
# Раз твоим модулям нужен Node.js, ставим стабильную 18-ю версию без ошибок в синтаксисе
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/* /tmp/*

# --- РАБОЧЕЕ ПРОСТРАНСТВО ---
RUN mkdir -p /data/private /data/Heroku
WORKDIR /data/Heroku

# Копируем файлы твоего форка Ratko, которые Render уже успешно скачал из GitHub
COPY . /data/Heroku

# --- УСТАНОВКА PYTHON ЗАВИСИМОСТЕЙ ---
RUN pip install --no-warn-script-location --no-cache-dir -U -r requirements.txt

# Информируем о порте (Render подменит его на свой внутренний автоматически)
EXPOSE 8080

# --- ЗАПУСК ВЕБ-ИНТЕРФЕЙСА ---
CMD ["python3", "-m", "heroku", "--root"]

