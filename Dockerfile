ARG PYTHON_VERSION=3.9
ARG PYTHON_BUILD_VERSION=$PYTHON_VERSION-buster

FROM python:${PYTHON_BUILD_VERSION}

RUN mkdir -p /opt/src
WORKDIR /opt/src

ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY hello_django .

CMD bash ./entrypoint.sh
