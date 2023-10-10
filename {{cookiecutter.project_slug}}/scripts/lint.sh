#!/bin/bash

echo "Running pyup_dirs..."
pyup_dirs --py38-plus --recursive {{cookiecutter.project_slug}} tests

echo "Running ruff..."
ruff {{cookiecutter.project_slug}} tests --fix

echo "Running black..."
black {{cookiecutter.project_slug}} tests
