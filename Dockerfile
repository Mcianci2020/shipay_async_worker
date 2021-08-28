FROM python:3.7


RUN useradd apps && mkdir /app && chown apps:apps -R /app

COPY --chown=apps:apps . /app
COPY --chown=apps:apps pyproject.toml /app

WORKDIR /app

RUN pip3 install poetry && poetry config virtualenvs.create false && poetry install --no-dev 

USER apps

EXPOSE 3001

ENTRYPOINT [ "faust", "-A", "app", "worker", "-l", "info" ]