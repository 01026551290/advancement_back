FROM python:3.8-slim-buster

WORKDIR /app

RUN apt-get update \
    && apt-get install -y gcc \
    && apt-get install -y default-libmysqlclient-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip

COPY requirements.txt /app/

RUN pip install -r requirements.txt

COPY . /app/

RUN python /app/manage.py collectstatic --noinput

CMD ["gunicorn", "--bind", "0.0.0.0:8000", "advancement_back.wsgi:application"]