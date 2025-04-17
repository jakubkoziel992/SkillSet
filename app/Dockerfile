FROM python:3.9-slim

WORKDIR /home/app

COPY . .

RUN apt update -y && \
    apt install curl -y && \
    apt install netcat-openbsd -y && \
    pip install --no-cache-dir -r requirements.txt

RUN chmod +x ./wait_for_db.sh && \
    addgroup python && \
    adduser --no-create-home --disabled-password --ingroup python python
USER python

EXPOSE 8000

CMD ["./wait_for_db.sh"]
