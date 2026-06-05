FROM python:3.11-slim

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libopenblas-dev \
    liblapack-dev \
    libx11-dev \
    libgtk-3-dev \
    libboost-python-dev \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .

RUN pip install --upgrade pip && \
    pip install flask gunicorn openpyxl requests numpy pandas opencv-python-headless opencv-contrib-python-headless twilio && \
    pip install dlib face_recognition

COPY . .

RUN mkdir -p uploads dataset data excel_reports models

CMD ["gunicorn", "app:app", "--bind", "0.0.0.0:10000"]
