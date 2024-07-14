FROM python:3.8-slim-buster

WORKDIR /app

# 필요한 패키지 설치
RUN apt-get update \
    && apt-get install -y gcc pkg-config default-libmysqlclient-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip

COPY requirements.txt /app/

RUN pip install -r requirements.txt
RUN pip install gunicorn

COPY . /app/

RUN python /app/manage.py collectstatic --noinput

CMD ["gunicorn", "--bind", "0.0.0.0:8000", "advancement_back.wsgi:application"]