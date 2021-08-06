FROM python:3.8

RUN mkdir /project


COPY . /project
COPY requirements.txt project/requirements.txt

WORKDIR /project
RUN pip install -r requirements.txt
