FROM python:3.9-slim

WORKDIR /home/app

COPY ./app/requirements.txt ./requirements.txt

RUN pip install --no-cache-dir -r requirements.txt

COPY gunicorn.conf.py .

COPY ./app .

RUN addgroup python && adduser --no-create-home --disabled-password --ingroup python python
USER python

EXPOSE 5000

CMD ["gunicorn"]
