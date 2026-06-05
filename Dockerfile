FROM python:3.11-slim

RUN apt-get update && apt-get install -y \
    libglib2.0-0 libsm6 libxext6 libxrender-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .

RUN pip install --upgrade pip && \
    pip install -r requirements.txt && \
    pip install https://github.com/z-mahmud22/Dlib_Windows_Python3.x/releases/download/v19.24.2/dlib-19.24.2-cp311-cp311-manylinux_2_17_x86_64.whl && \
    pip install face_recognition

COPY . .

RUN mkdir -p uploads dataset data excel_reports models

CMD ["gunicorn", "app:app", "--bind", "0.0.0.0:10000"]
