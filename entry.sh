#!/bin/bash

echo "===================="

git config --global user.name "${GITHUB_ACTOR}"
git config --global user.email "${INPUT_EMAIL}"
git config --global --add safe.directory /github/workspace

echo "===================="
pip install -r /app/requirements.txt
python3 /app/S1_FeatureCal/autoTest.py