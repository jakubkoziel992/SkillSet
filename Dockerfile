FROM python:3.9-slim

WORKDIR /home/app

COPY requirements.txt ./requirements.txt

RUN pip install -r requirements.txt

COPY ./app/ .

RUN addgroup python && adduser --no-create-home --disabled-password --ingroup python python
USER python

EXPOSE 5000

CMD ["python", "app.py"]
