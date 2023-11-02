FROM ubuntu

RUN apt update
RUN apt install -y python3
RUN apt install -y pip
RUN apt -y install vim
RUN pip install flask

COPY app.py /opt/app.py

ENTRYPOINT FLASK_APP=/opt/app.py flask run --host=0.0.0.0
