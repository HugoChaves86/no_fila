FROM python:3.11.5-slim as builder

# Always set a working directory
WORKDIR /app
# Sets utf-8 encoding for Python et al
ENV LANG=C.UTF-8
# Turns off writing .pyc files; superfluous on an ephemeral container.
ENV PYTHONDONTWRITEBYTECODE=1
# Seems to speed things up
ENV PYTHONUNBUFFERED=1
# Ensures that the python and pip executables used
# in the image will be those from our virtualenv.
ENV PATH="/venv/bin:$PATH"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gettext build-essential && \
    rm -rf /var/lib/apt/lists/*

RUN python -m venv /venv && \
    pip install --upgrade pip && \
    pip install poetry

COPY ./requirements.txt ./requirements.txt
RUN pip install -r requirements.txt


FROM python:3.11.5-slim AS app
WORKDIR /app

# Extra python env
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PIP_DISABLE_PIP_VERSION_CHECK=1
ENV PATH="/venv/bin:$PATH"

EXPOSE 8000

COPY --from=builder /venv /venv
COPY /app ./

ENTRYPOINT ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000", "--workers", "4"]