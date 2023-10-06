#!/bin/bash

echo "Running pyup_dirs..."
pyup_dirs --py38-plus --recursive {{cookiecutter.repo_name}} tests

echo "Running ruff..."
ruff {{cookiecutter.repo_name}} tests --fix

echo "Running black..."
black {{cookiecutter.repo_name}} tests
