#!/bin/bash

# Activate virtual environment if not already activated
if [ ! -d "/app/.venv" ]; then
  python3.10 -m venv /app/.venv
  source /app/.venv/bin/activate
  pip install --upgrade pip
  pip install -r /app/requirements.txt
else
  source /app/.venv/bin/activate
fi

# Configure git (if necessary for the application)
git config --global user.name "${GITHUB_ACTOR}"
git config --global user.email "${INPUT_EMAIL}"
git config --global --add safe.directory /github/workspace

# Run the Python application
python3 /app/S1_FeatureCal/autoTest.py
