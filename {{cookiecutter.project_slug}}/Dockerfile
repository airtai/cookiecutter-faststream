FROM python:3.9-slim-bullseye

SHELL ["/bin/bash", "-c"]
WORKDIR /project

ADD {{cookiecutter.project_slug}} /project/{{cookiecutter.project_slug}}
COPY pyproject.toml /project/

RUN pip install --no-cache-dir .

CMD ["faststream", "run", "--workers", "1", "{{cookiecutter.project_slug}}.application:app"]
