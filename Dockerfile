FROM python:3.14-slim 
ENV PYTHONDONTWRITEBYTECODE 1 
ENV PYTHONUNBUFFERED 1 
WORKDIR /app 
 
RUN sed -i 's|http://deb.debian.org|https://deb.debian.org|g; s|http://security.debian.org|https://security.debian.org|g' /etc/apt/sources.list.d/debian.sources \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        default-libmysqlclient-dev \
        pkg-config \
        gcc \
        libc6-dev \
    && rm -rf /var/lib/apt/lists/*
 
COPY requirements.txt /app/ 
RUN pip install --upgrade pip 
 
RUN pip install --no-cache-dir -r requirements.txt 
COPY . /app/ 
 
EXPOSE 8000 
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"] 