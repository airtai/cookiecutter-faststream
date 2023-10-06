#!/bin/bash
set -e

echo "Running mypy..."
mypy {{cookiecutter.repo_name}}

echo "Running bandit..."
bandit -c pyproject.toml -r {{cookiecutter.repo_name}}
