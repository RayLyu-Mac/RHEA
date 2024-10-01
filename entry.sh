#!/bin/bash

# Activate virtual environment if it exists; otherwise, create and install dependencies
if [ ! -d "/app/.venv" ]; then
    echo "Virtual environment not found. Creating one..."
    python3.10 -m venv /app/.venv
    source /app/.venv/bin/activate
    echo "Upgrading pip..."
    pip install --upgrade pip
    echo "Installing dependencies from requirements.txt..."
    pip install -r /app/requirements.txt
else
    echo "Virtual environment found. Activating..."
    source /app/.venv/bin/activate
fi

# Ensure all required libraries are installed
pip check
if [ $? -ne 0 ]; then
    echo "Some libraries are missing or incompatible. Reinstalling dependencies..."
    pip install -r /app/requirements.txt
else
    echo "All dependencies are satisfied."
fi

# Optionally configure git
git config --global user.name "${GITHUB_ACTOR}"
git config --global user.email "${INPUT_EMAIL}"
git config --global --add safe.directory /github/workspace

# Run the Python application
python3 /app/S1_FeatureCal/autoPrep.py
