# Use Ubuntu 22.04 (Jammy) as the base image
FROM ubuntu:22.04

# Update the package list and install Python 3.10 and necessary dependencies
RUN apt-get update && apt-get install -y \
    python3.10 \
    python3.10-venv \
    python3-pip \
    git \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /app

# Copy the S1_FeatureCal directory from the host to the container
COPY ./S1_FeatureCal /app/S1_FeatureCal

# Copy the requirements.txt file from the host to the container
COPY requirements.txt /app/requirements.txt

# Verify that the directories and files are properly copied
RUN ls -al /app/S1_FeatureCal && ls -al /app/requirements.txt

# Copy entry script and make it executable
COPY entry.sh /entry.sh
RUN chmod +x /entry.sh

# Set the entry point to the entry.sh script
ENTRYPOINT [ "/entry.sh" ]
