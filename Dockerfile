FROM python:3.11-slim

RUN apt-get update && apt-get install -y \
    libglib2.0-0 libsm6 libxext6 libxrender-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .

RUN pip install --upgrade pip --root-user-action=ignore && \
    pip install -r requirements.txt --root-user-action=ignore

COPY . .

RUN mkdir -p uploads dataset data excel_reports models

CMD ["gunicorn", "app:app", "--bind", "0.0.0.0:10000", "--timeout", "120"]
