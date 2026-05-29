FROM python:3.14 AS python-base
FROM python-base AS builder-base

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
FROM python:3.10-slim AS python-base
ENV DOCKER=true
ENV GIT_PYTHON_REFRESH=quiet

ENV PIP_NO_CACHE_DIR=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

RUN apt update && apt install libcairo2 git build-essential -y --no-install-recommends
RUN rm -rf /var/lib/apt/lists /var/cache/apt/archives /tmp/*

RUN mkdir /data

COPY . /data/Heroku
WORKDIR /data/Heroku

RUN pip install --no-warn-script-location --no-cache-dir -U -r requirements.txt

# Запускаем бота с включенным веб-интерфейсом. 
# Так как это модуль heroku, он автоматически подхватит порт от Render из переменной $PORT
CMD ["python3", "-m", "heroku", "--root"]
x -o nodesource_setup.sh && \
    bash nodesource_setup.sh && \
    apt-get install -y nodejs && \
    rm nodesource_setup.sh
RUN rm -rf /var/lib/apt/lists/ /var/cache/apt/archives/ /tmp/*

WORKDIR /data
RUN mkdir /data/private

RUN git clone https://github.com/unsidogandon/ratko /data/ratko
WORKDIR /data/Heroku
RUN git fetch && git checkout master && git pull

RUN pip install --no-warn-script-location --no-cache-dir -U -r requirements.txt

EXPOSE 8080
CMD ["python", "-m", "heroku", "--root"]

