#!/bin/bash
set -e

echo "Running mypy..."
mypy {{cookiecutter.project_slug}}

echo "Running bandit..."
bandit -c pyproject.toml -r {{cookiecutter.project_slug}}
