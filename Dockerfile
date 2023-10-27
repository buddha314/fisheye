# syntax=docker/dockerfile:1
FROM python:3.12
#FROM ubuntu:23.10
WORKDIR /code
#ENV FLASK_APP=app.py
#ENV FLASK_RUN_HOST=0.0.0.0
#RUN apk add --no-cache gcc musl-dev linux-headers
COPY . .
#RUN apt-get -y install guvicorn
RUN pip install --upgrade pip
RUN pip install -r requirements.txt
RUN pip install poetry
RUN poetry --version
EXPOSE 5000

CMD ["uvicorn", "fisheye-api.main:app", "--host", "0.0.0.0", "--port", "5000"]