FROM python:3.9-slim-bullseye

SHELL ["/bin/bash", "-c"]
WORKDIR /project

ADD {{cookiecutter.repo_name}} /project/{{cookiecutter.repo_name}}
COPY pyproject.toml /project/

RUN pip install --no-cache-dir .

CMD ["faststream", "run", "--workers", "1", "{{cookiecutter.repo_name}}.application:app"]
