FROM ubuntu:latest

# Update and install Python, pip, and git
RUN apt-get update && apt-get install -y \
    git

RUN apt-install python3-3.10
RUN apt-install python3-pip

# Set the working directory inside the container
WORKDIR /app

# Copy the entire S1_FeatureCal directory from the host to the container
COPY ./S1_FeatureCal /app/S1_FeatureCal

# Use pip3 (linked to Python 3) to install requirements
RUN pip3 install --no-cache-dir -r /app/S1_FeatureCal/requirements.txt