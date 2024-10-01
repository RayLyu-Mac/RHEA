FROM ubuntu:latest

# Update and install Python, pip, git, and other dependencies
RUN apt-get update && apt-get install -y python3.10 \
    
    python3-pip \
    git \
    python3-venv \
    build-essential \
    setuptools \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /app

# Copy the S1_FeatureCal directory from the host to the container
COPY ./S1_FeatureCal /app/S1_FeatureCal

# Copy the requirements.txt file from the host to the container
COPY requirements.txt /app/requirements.txt

# Verify that the directories and files are properly copied
RUN ls -al /app/S1_FeatureCal && ls -al /app/requirements.txt

# Create a virtual environment and install dependencies in one layer
RUN python3 -m venv .venv && \
    /bin/bash -c "source .venv/bin/activate && python3 -m pip install --upgrade pip && python3 -m pip install -r /app/requirements.txt"

# Optionally, set the default command to activate the virtual environment and run your application
COPY entry.sh /entry.sh

RUN chmod -R 775 /entry.sh
ENTRYPOINT [ "/entry.sh" ]
