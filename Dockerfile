FROM ubuntu:24.10

RUN apt update && apt install python3

RUN pip install requirements.txt

WORKDIR app

COPY . app/

CMD ["python" "app.py"]
