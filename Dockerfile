FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    python3.10 \
    python3-pip \
    git 

WORKDIR /app
COPY ./S1_FeatureCal /app/S1_FeatureCal
RUN pip install -r /app/S1_FeatureCal/requirements.txt
    
