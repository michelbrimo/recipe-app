FROM python:3.9-alpine3.13
LABEL maintainer="reciper-app.com"

ENV PYTHONBUFFERED=1

COPY ./requirements.txt /tmp/reqirements.txt
COPY ./requirements.dev.txt /tmp/reqirements.dev.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

ARG DEV=false

RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/reqirements.txt && \
    if [ $DEV = "true" ]; \
      then /py/bin/pip install -r /tmp/reqirements.dev.txt; \
    fi && \
    rm -rf /tmp&& \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

ENV PATH="/py/bin:$PATH"

USER django-user